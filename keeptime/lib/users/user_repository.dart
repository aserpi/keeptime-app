import 'dart:convert';

import 'package:http/http.dart';
import 'package:keeptime/network.dart';
import 'package:keeptime/users/user.dart';

import 'iuser.dart';

// Basic in-memory caching
final Map<String, CachedUser> _users = Map<String, CachedUser>();

Future<IUser> getUser(String url, {bool forceRefresh = false}) async {
  if(! forceRefresh && _users.containsKey(url)) {
    final cachedUser = _users[url];
    if(DateTime.now().difference(cachedUser.cachedAt) < _expireCacheIn) {
      return cachedUser.user;
    }
  }

  final response = await get(url, headers: authenticatedJsonHeaders());
  final user = User.fromJson(json.decode(response.body));
  _users[user.url] = CachedUser(user);
  return user;
}

class CachedUser {
  final IUser user;
  final DateTime cachedAt;

  CachedUser(this.user) : cachedAt = DateTime.now();
}

const _expireCacheIn = Duration(minutes: 10);
