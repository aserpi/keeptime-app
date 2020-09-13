import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/user_preferences_bloc.dart';
import 'package:keeptime/blocs/user_preferences_event.dart';
import 'package:keeptime/blocs/user_preferences_state.dart';
import 'package:keeptime/generated/l10n.dart';

class UserPreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocConsumer<UserPreferencesBloc, UserPreferencesState>(
        listener: (context, state) => Navigator.of(context).pop(),
        listenWhen: (previous, current) => current is LogoutSuccess,
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).user_preferences),
            ),
            body: _UserPreferencesPageBody()),
        buildWhen: (previous, current) => current is! LogoutSuccess,
      ),
      create: (BuildContext context) => UserPreferencesBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
    );
  }
}

class _UserPreferencesPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<UserPreferencesBloc>(context).state;

    return Stack(
      children: <Widget>[
        if (state is LoggingOut) LinearProgressIndicator(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          onTap: state is LoggingOut ? null : () {BlocProvider.of<UserPreferencesBloc>(context).add(LogoutButtonPressed());},
          subtitle: Text(S.of(context).logout_info),
          title: Text(S.of(context).logout),
        )
      ],
    );
  }
}
