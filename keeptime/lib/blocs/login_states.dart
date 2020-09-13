import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:keeptime/network/exceptions.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final NetworkException error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
