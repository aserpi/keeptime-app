import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  final String currentUserId;
  AuthenticationAuthenticated({@required this.currentUserId});

  @override
  List<Object> get props => [currentUserId];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}
