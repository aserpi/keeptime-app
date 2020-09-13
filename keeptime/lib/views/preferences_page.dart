import 'package:flutter/material.dart';

import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/views/user_preferences_page.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserPreferencesPage()));
      },
      title: Text(S.of(context).user_preferences),
    );
  }
}
