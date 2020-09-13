import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/network/client.dart';
import 'package:keeptime/blocs/authentication_events.dart';
import 'package:keeptime/blocs/authentication_states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticationUninitialized();
      try {
        final currentUserId = await loginWithStoredCredentials();
        if (currentUserId == null) {
          yield AuthenticationUnauthenticated(error: null);
        } else {
          yield AuthenticationAuthenticated(currentUserId: currentUserId);
        }
      } catch (error) {
        yield AuthenticationUnauthenticated(error: error);
      }
    }
    else if (event is LoggedIn) {
      yield AuthenticationAuthenticated(currentUserId: event.currentUserId);
    }
    else if (event is LoggedOut) {
      yield AuthenticationUnauthenticated(error: event.error);
    }
  }
}
