import 'package:json_api/document.dart';

import 'user.dart';

class RegisteredUser extends User {
  final String email;

  RegisteredUser(String id, String name, String username, this.email)
      : super(id, name, username);

  factory RegisteredUser.fromDocument(Document document) {
    final res = (document.data as ResourceData).unwrap();
    final attributes = res.attributes;

    return RegisteredUser(res.id, attributes["name"], attributes["username"],
        attributes["email"]);
  }

  @override
  List<Object> get props => [id];
}
