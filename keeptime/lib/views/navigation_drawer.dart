import 'package:curved_drawer/curved_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/blocs/main_bloc.dart';
import 'package:keeptime/blocs/main_events.dart';
import 'package:keeptime/blocs/main_states.dart';
import 'package:keeptime/generated/l10n.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<MainBloc>(context).state;

    void onItemTap(int index) {
      switch (index) {
        case 0:
          {
            BlocProvider.of<MainBloc>(context).add(LogButtonPressed());
            break;
          }
        case 1:
          {
            BlocProvider.of<MainBloc>(context).add(WorkspacesButtonPressed());
            break;
          }
        case 2:
          {
            BlocProvider.of<MainBloc>(context).add(PreferencesButtonPressed());
            break;
          }
      }
      Navigator.pop(context);
    }

    int selectedIdx;
    if (state is HomeLog) {
      selectedIdx = 0;
    } else if (state is HomeWorkspaces) {
      selectedIdx = 1;
    } else if (state is HomePreferences) {
      selectedIdx = 2;
    } else {
      throw UnimplementedError("Unknown state " + state.runtimeType.toString());
    }

    final List<DrawerItem> drawerItems = <DrawerItem>[
      DrawerItem(icon: Icon(Icons.alarm), label: S.of(context).log),
      DrawerItem(icon: Icon(Icons.people), label: S.of(context).workspaces),
      DrawerItem(icon: Icon(Icons.settings), label: S.of(context).preferences)
    ];

    return CurvedDrawer(
        index: selectedIdx, items: drawerItems, onTap: onItemTap);
  }
}
