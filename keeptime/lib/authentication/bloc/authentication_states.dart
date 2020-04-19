import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../network/exceptions.dart';

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

class AuthenticationUnauthenticated extends AuthenticationState {
  final NetworkException error;
  AuthenticationUnauthenticated({@required this.error});
}
