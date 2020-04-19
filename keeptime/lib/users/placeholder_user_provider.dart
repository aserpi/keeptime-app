import '../network/network.dart';
import '../repository/resource_provider.dart';
import 'placeholder_user.dart';

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
