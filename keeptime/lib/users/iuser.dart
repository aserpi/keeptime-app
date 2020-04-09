import 'package:equatable/equatable.dart';

abstract class IUser extends Equatable {
  final String name;
  final String url;
  final String username;

  const IUser(this.name, this.username, this.url);
}
