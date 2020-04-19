import '../repository/cached_resource.dart';
import '../repository/resource_repository.dart';
import 'registered_user.dart';
import 'registered_user_provider.dart';

/// Basic in-memory caching for registered users.
class RegisteredUserRepository extends ResourceRepository<RegisteredUser> {
  RegisteredUserRepository._privateConstructor() : super(Duration(minutes: 10));

  static final RegisteredUserRepository instance =
      RegisteredUserRepository._privateConstructor();

  bool add(RegisteredUser user, {bool force = false}) {
    if (!force && resources.containsKey(user.id)) return false;

    resources[user.id] = CachedResource(user);
    return true;
  }

  Future<RegisteredUser> fetch(String id, {bool forceRefresh = false}) async {
    if (!forceRefresh && resources.containsKey(id)) {
      final cachedUser = resources[id];
      if (DateTime.now().difference(cachedUser.cachedAt) < expireCacheIn) {
        return cachedUser.resource;
      }
    }

    final user = await RegisteredUserProvider.instance.fetch(id);
    resources[user.id] = CachedResource(user);
    return user;
  }
}
