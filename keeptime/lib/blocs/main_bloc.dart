import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/main_events.dart';
import 'package:keeptime/blocs/main_states.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AuthenticationBloc authenticationBloc;

  MainBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(HomeWorkspaces());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is LogButtonPressed) {
      yield HomeLog();
    } else if (event is PreferencesButtonPressed) {
      yield HomePreferences();
    } else if (event is WorkspacesButtonPressed) {
      yield HomeWorkspaces();
    } else {
      throw UnimplementedError("Unknown event " + event.runtimeType.toString());
    }
  }
}
