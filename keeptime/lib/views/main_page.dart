import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/main_bloc.dart';
import 'package:keeptime/blocs/main_states.dart';
import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/views/navigation_drawer.dart';
import 'package:keeptime/views/preferences_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text(S.of(context).app_name)),
          body: _HomePageBody(),
          drawer: NavigationDrawer(),
        ),
      ),
      create: (BuildContext context) => MainBloc(authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainState state = BlocProvider.of<MainBloc>(context).state;

    if(state is HomePreferences) {
      return PreferencesPage();
    }

    return Text("Home page");
  }
}
