import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/authentication_states.dart';
import 'package:keeptime/blocs/main_bloc.dart';
import 'package:keeptime/blocs/main_events.dart';
import 'package:keeptime/blocs/main_states.dart';
import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/models/registered_user.dart';
import 'package:keeptime/repositories/registered_user_repository.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<MainBloc>(context).state;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<RegisteredUser>(
              future: RegisteredUserRepository.instance.fetch(
                  (BlocProvider.of<AuthenticationBloc>(context).state
                          as AuthenticationAuthenticated)
                      .currentUserId),
              builder: (BuildContext context,
                  AsyncSnapshot<RegisteredUser> snapshot) {
                if (snapshot.hasData) {
                  final currentUser = snapshot.data;
                  return UserAccountsDrawerHeader(
                    accountEmail: Text("@" + currentUser.name),
                    accountName: Text(currentUser.username),
                  );
                } else {
                  return DrawerHeader(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryTextTheme.headline1.color),
                      ),
                    ),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.zero,
                  );
                }
              }),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.alarm),
                  selected: state is HomeLog,
                  title: Text(S.of(context).log),
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  selected: state is HomeWorkspaces,
                  title: Text(S.of(context).workspaces),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            onTap: () {
              BlocProvider.of<MainBloc>(context)
                  .add(PreferencesButtonPressed());
              Navigator.pop(context);
            },
            selected: state is HomePreferences,
            title: Text(S.of(context).preferences),
          )
        ],
      ),
    );
  }
}
