import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  final String message;
  const LoggedOut({@required this.message});
}
