import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../authentication/authentication.dart';
import '../../network/network.dart';
import 'login_events.dart';
import 'login_states.dart';

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
