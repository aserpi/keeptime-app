import 'package:meta/meta.dart';

import 'cached_resource.dart';

/// Basic in-memory caching for a resource type.
abstract class ResourceRepository<T> {
  @protected
  final Map<String, CachedResource<T>> resources =
      Map<String, CachedResource<T>>();

  @protected
  final Duration expireCacheIn;

  ResourceRepository(this.expireCacheIn);

  bool add(T resource, {bool force = false});

  Future<T> fetch(String id, {bool forceRefresh = false});

  T peek(String id) {
    return resources[id]?.resource;
  }

  T remove(String id) {
    return resources.remove(id)?.resource;
  }
}
