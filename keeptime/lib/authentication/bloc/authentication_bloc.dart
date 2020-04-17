import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/network.dart';
import 'authentication_events.dart';
import 'authentication_states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticationUninitialized();
      try {
        final currentUserId = await loginWithStoredCredentials();
        if (currentUserId == null) {
          yield AuthenticationUnauthenticated();
        } else {
          yield AuthenticationAuthenticated(currentUserId: currentUserId);
        }
      } catch (_) {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LoggedIn) {
      yield AuthenticationAuthenticated(currentUserId: event.currentUserId);
    } else if (event is LoggedOut) {
      yield AuthenticationUnauthenticated();
    }
  }
}
