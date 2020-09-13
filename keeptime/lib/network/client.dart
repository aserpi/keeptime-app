import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:json_api/client.dart';
import 'package:json_api/document.dart';
import 'package:json_api/http.dart';
import 'package:json_api/routing.dart';

import 'package:keeptime/models/registered_user.dart';
import 'package:keeptime/network/exceptions.dart';
import 'package:keeptime/repositories/registered_user_repository.dart';

/// Client for JSON:API requests.
RoutingClient client;
const _timeLimit = Duration(seconds: 10);

/// Logs in with email and password.
///
/// If the login is successful, it stores the current user in the repository and
/// returns their id.
///
/// It can throw [NetworkException]
Future<String> loginWithEmail(
    String email, String password, String server) async {
  final body = {"email": email, "password": password};

  // Secure communication unless otherwise stated.
  if (!server.startsWith("http")) server = "https://$server";
  Uri serverUrl = Uri.parse(server);

  // Append API path to the URI supplied by the user.
  // Last segment is empty to create a URI with a trailing slash.
  serverUrl = serverUrl.replace(
      pathSegments: serverUrl.pathSegments + ["api", "v1", ""]);
  final loginUrl = serverUrl.resolve("auth/sign_in.json");

  try {
    final response = await http.post(loginUrl, body: body).timeout(_timeLimit);
    switch (response.statusCode) {
      case 200:
        _updateClient(serverUrl);
        _updateCredentials(response.headers);
        _updateServerUrl(serverUrl);
        final currentUser = RegisteredUser.fromDocument(Document.fromJson(
            jsonDecode(response.body), ResourceData.fromJson));
        RegisteredUserRepository.instance.add(currentUser);
        return currentUser.id;
        break;
      case 401:
        throw UnauthorizedException();
      default:
      // Other response are not compliant with the API, therefore it is like the
      // server does not exist.
        throw NoServerException();
    }
  } on http.ClientException {
    throw UnknownNetworkException();
  } on SocketException {
    throw NoInternetException();
  } on TimeoutException {
    throw NoServerException();
  } on TlsException {
    throw UnknownNetworkException();
  }
}

/// Logs the user in with stored credentials.
///
/// If the login is successful, it stores the current user in the repository and
/// returns their id.
///
/// It can throw [NetworkException].
Future<String> loginWithStoredCredentials() async {
  if (!await _readCredentials()) return null;

  final validateUrl = _serverUrl
      .resolve("auth/validate_token")
      .replace(queryParameters: _authenticationHeaders);
  try {
    // The check invalidates the credentials.
    final response = await http.get(validateUrl).timeout(_timeLimit);
    switch (response.statusCode) {
      case 200:
        _updateCredentials(response.headers);
        final currentUser = RegisteredUser.fromDocument(Document.fromJson(
            jsonDecode(response.body), ResourceData.fromJson));
        RegisteredUserRepository.instance.add(currentUser);
        _updateClient(_serverUrl);
        return currentUser.id;
      case 401:
        throw UnauthorizedException();
      default:
        throw NoServerException();
    }
  } on http.ClientException {
    throw UnknownNetworkException();
  } on SocketException {
    throw NoInternetException();
  } on TimeoutException {
    throw NoServerException();
  } on TlsException {
    throw UnknownNetworkException();
  }
}

/// Logs out the user.
///
/// If [force] is true, then the credentials are removed from the app
/// even if no response is received from the server.
Future<void> logout({bool force: false}) async {
  final logoutUrl = _serverUrl.resolve("auth/sign_out.json");
  bool success = false;

  try {
    await http.delete(logoutUrl).timeout(_timeLimit);
    success = true;
  } on SocketException {
    throw NoInternetException();
  } finally {
    if (success || force) {
      client = null;
      await _removeCredentials();
    }
  }
}

final _authenticationHeaders = Map<String, String>();
Uri _serverUrl;
final _storage = FlutterSecureStorage();

/// A wrapper over [HttpHandler] that allows authentication.
class _AuthenticatingHttpHandler implements HttpHandler {
  final HttpHandler handler;

  _AuthenticatingHttpHandler(this.handler);

  @override
  Future<HttpResponse> call(HttpRequest request) async {
    _addAuthenticationHeaders(request);
    try {
      final response = await handler(request).timeout(_timeLimit);
      _updateCredentials(response.headers);
      return response;
    } on http.ClientException {
      throw UnknownNetworkException();
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw NoServerException();
    } on TlsException {
      throw UnknownNetworkException();
    }
  }
}

/// Adds authentication headers to a request if they are not present.
void _addAuthenticationHeaders(HttpRequest request) async {
  if (!_authenticationHeaders.containsKey("authentication-header")) return;

  request.headers.putIfAbsent(
      "access-token", () => _authenticationHeaders["access-token"]);
  request.headers.putIfAbsent("client", () => _authenticationHeaders["client"]);
  request.headers.putIfAbsent("uid", () => _authenticationHeaders["uid"]);
}

/// Loads network environment (credentials, server URL) from secure storage.
Future<bool> _readCredentials() async {
  final List<Future<String>> futures = [];
  futures.add(_storage.read(key: "access-token"));
  futures.add(_storage.read(key: "client"));
  futures.add(_storage.read(key: "uid"));
  futures.add(_storage.read(key: "serverUrl"));
  final credentials = await Future.wait(futures);

  if (credentials.contains(null)) {
    _removeCredentials();
    return false;
  }

  _authenticationHeaders["access-token"] = credentials[0];
  _authenticationHeaders["client"] = credentials[1];
  _authenticationHeaders["uid"] = credentials[2];
  _serverUrl = Uri.parse(credentials[3]);
  return true;
}

/// Removes credentials, both in memory and in secure storage.
Future<void> _removeCredentials() async {
  client = null;
  _authenticationHeaders.clear();
  _serverUrl = null;

  final List<Future<void>> futures = [];
  futures.add(_storage.delete(key: "access-token"));
  futures.add(_storage.delete(key: "client"));
  futures.add(_storage.delete(key: "uid"));
  futures.add(_storage.delete(key: "serverUrl"));

  await Future.wait(futures);
}

/// Updates the JSON:API client.
void _updateClient(Uri serverUrl) {
  final routing = StandardRouting(serverUrl);
  final handler = _AuthenticatingHttpHandler(DartHttp(http.Client()));
  client = RoutingClient(JsonApiClient(handler), routing);
}

/// Updates securely stored credentials.
Future<void> _updateCredentials(Map<String, String> headers) async {
  if (!headers.containsKey("access-token")) return;
  final accessToken = headers["access-token"];
  final client = headers["client"];
  final uid = headers["uid"];

  _authenticationHeaders["access-token"] = accessToken;
  _authenticationHeaders["client"] = client;
  _authenticationHeaders["uid"] = uid;

  final List<Future<void>> futures = [];
  futures.add(_storage.write(key: "access-token", value: accessToken));
  futures.add(_storage.write(key: "client", value: client));
  futures.add(_storage.write(key: "uid", value: uid));
  await Future.wait(futures);
}

/// Updates the server URL, both in memory and in secure storage.
Future<void> _updateServerUrl(Uri serverUrl) async {
  _serverUrl = serverUrl;
  await _storage.write(key: "serverUrl", value: _serverUrl.toString());
}
