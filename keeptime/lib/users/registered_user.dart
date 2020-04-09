import 'package:keeptime/users/user.dart';

class RegisteredUser extends User {
  final String email;

  const RegisteredUser(String name, String username, this.email, url)
      : super(name, username, url);

  RegisteredUser.fromJson(Map<String, dynamic> json)
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
