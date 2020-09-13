import 'package:json_api/document.dart';

import 'package:keeptime/models/user.dart';

class PlaceholderUser extends User {
  PlaceholderUser(String name, String username, url)
      : super(name, username, url);

  factory PlaceholderUser.fromDocument(Document document) {
    final res = (document.data as ResourceData).unwrap();
    final attributes = res.attributes;

    return PlaceholderUser(res.id, attributes["name"], attributes["username"]);
  }

  @override
  List<Object> get props => [id];
}
