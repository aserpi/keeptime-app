import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final String server;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
    @required this.server
  });

  @override
  List<Object> get props => [email, password, server];
}

class LoginSnackbarDismissed extends LoginEvent {
  @override
  List<Object> get props => [];
}
