import 'package:keeptime/models/placeholder_user.dart';
import 'package:keeptime/providers/placeholder_user_provider.dart';
import 'package:keeptime/repositories/cached_resource.dart';
import 'package:keeptime/repositories/resource_repository.dart';

/// Basic in-memory caching for placeholder users.
class PlaceholderUserRepository extends ResourceRepository<PlaceholderUser> {
  PlaceholderUserRepository._privateConstructor()
      : super(Duration(minutes: 10));

  static final PlaceholderUserRepository instance =
      PlaceholderUserRepository._privateConstructor();

  bool add(PlaceholderUser user, {bool force = false}) {
    if (!force && resources.containsKey(user.id)) return false;

    resources[user.id] = CachedResource(user);
    return true;
  }

  Future<PlaceholderUser> fetch(String id, {bool forceRefresh = false}) async {
    if (!forceRefresh && resources.containsKey(id)) {
      final cachedUser = resources[id];
      if (DateTime.now().difference(cachedUser.cachedAt) < expireCacheIn) {
        return cachedUser.resource;
      }
    }

    final user = await PlaceholderUserProvider.instance.fetch(id);
    resources[user.id] = CachedResource(user);
    return user;
  }
}
