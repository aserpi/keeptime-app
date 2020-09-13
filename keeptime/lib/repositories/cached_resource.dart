/// A cached resource.
class CachedResource<T> {
  final T resource;
  final DateTime cachedAt;

  CachedResource(this.resource) : this.cachedAt = DateTime.now();
}
