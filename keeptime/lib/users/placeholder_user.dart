import 'package:keeptime/users/user.dart';

class PlaceholderUser extends User {

  const PlaceholderUser(String name, String username, url)
      : super(name, username, url);

  PlaceholderUser.fromJson(Map<String, dynamic> json)
      : super(json["name"], json["username"], json["url"]);

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username
  };

  @override
  List<Object> get props => [url];
}
