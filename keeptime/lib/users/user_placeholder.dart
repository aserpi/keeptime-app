import 'package:keeptime/users/iuser.dart';

class UserPlaceholder extends IUser {

  const UserPlaceholder(String name, String username, url)
      : super(name, username, url);

  UserPlaceholder.fromJson(Map<String, dynamic> json)
      : super(json["name"], json["username"], json["url"]);

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username
  };

  @override
  List<Object> get props => [url];
}
