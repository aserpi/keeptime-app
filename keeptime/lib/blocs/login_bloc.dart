import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/authentication_events.dart';
import 'package:keeptime/blocs/login_events.dart';
import 'package:keeptime/blocs/login_states.dart';
import 'package:keeptime/network/client.dart';
import 'package:keeptime/network/exceptions.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null), super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        authenticationBloc.add(LoggedIn(
            currentUserId: await loginWithEmail(
                event.email, event.password, event.server)));
        yield LoginInitial();
      } on NetworkException catch (error) {
        yield LoginFailure(error: error);
      }
    }
    else if (event is LoginSnackbarDismissed) {
      yield LoginInitial();
    }
  }
}
