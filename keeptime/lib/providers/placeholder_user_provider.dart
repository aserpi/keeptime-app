import 'package:keeptime/models/placeholder_user.dart';
import 'package:keeptime/network/client.dart';
import 'package:keeptime/network/exceptions.dart';
import 'package:keeptime/providers/resource_provider.dart';

/// Provider for placeholder users.
class PlaceholderUserProvider extends ResourceProvider<PlaceholderUser> {
  PlaceholderUserProvider._privateConstructor();

  static final PlaceholderUserProvider instance =
      PlaceholderUserProvider._privateConstructor();

  Future<PlaceholderUser> fetch(String id) async {
    final response = await client.fetchResource("placeholder-users", id);
    if (response.isSuccessful) {
      return PlaceholderUser.fromDocument(response.document);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception("Can not fetch PlaceholderUser with id '$id'");
    }
  }
}
