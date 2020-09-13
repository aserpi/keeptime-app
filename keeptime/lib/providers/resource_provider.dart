/// Basic provider for a resource type.
abstract class ResourceProvider<T> {
  Future<T> fetch(String id);
}
