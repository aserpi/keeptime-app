import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:keeptime/network/exceptions.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String currentUserId;
  const LoggedIn({@required this.currentUserId});

  @override
  List<Object> get props => [currentUserId];
}

class LoggedOut extends AuthenticationEvent {
  final NetworkException error;
  const LoggedOut({this.error});
}
