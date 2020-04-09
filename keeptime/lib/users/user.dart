import 'package:keeptime/users/iuser.dart';

class User extends IUser {
  final String email;

  const User(String name, String username, this.email, url)
      : super(name, username, url);

  User.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        super(json["name"], json["username"], json["url"]);

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "username": username
  };

  @override
  List<Object> get props => [url];
}
