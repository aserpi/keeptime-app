import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/authentication_events.dart';
import 'package:keeptime/blocs/user_preferences_event.dart';
import 'package:keeptime/blocs/user_preferences_state.dart';
import 'package:keeptime/network/client.dart';

class UserPreferencesBloc extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  final AuthenticationBloc authenticationBloc;

  UserPreferencesBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(InitialUserPreferencesState());

  @override
  Stream<UserPreferencesState> mapEventToState(
      UserPreferencesEvent event,) async* {
    if (event is LogoutButtonPressed) {
      yield LoggingOut();
      try {
        await logout();
        authenticationBloc.add(LoggedOut());
        yield LogoutSuccess();
      } catch (_) {
        yield InitialUserPreferencesState();
      }
    } else {
      throw StateError("Unknown state " + state.runtimeType.toString());
    }
  }
}
