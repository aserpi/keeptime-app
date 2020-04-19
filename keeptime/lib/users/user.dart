import 'package:equatable/equatable.dart';

abstract class User extends Equatable {
  final String id;
  final String name;
  final String username;

  User(this.id, this.name, this.username);
}
