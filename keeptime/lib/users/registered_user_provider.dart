import '../network/network.dart';
import '../repository/resource_provider.dart';
import 'registered_user.dart';

class RegisteredUserProvider extends ResourceProvider<RegisteredUser> {
  RegisteredUserProvider._privateConstructor();

  static final RegisteredUserProvider instance =
      RegisteredUserProvider._privateConstructor();

  Future<RegisteredUser> fetch(String id) async {
    final response = await client.fetchResource("registered_users", id);
    if (response.isSuccessful) {
      return RegisteredUser.fromDocument(response.document);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception("Can not fetch RegisteredUser with id '$id'");
    }
  }
}
