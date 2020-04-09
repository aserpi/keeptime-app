import 'package:equatable/equatable.dart';

abstract class User extends Equatable {
  final String name;
  final String url;
  final String username;

  const User(this.name, this.username, this.url);
}
