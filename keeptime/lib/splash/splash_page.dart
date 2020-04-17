import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.primaryTextTheme.headline1.copyWith(height: 1.0);

    return Scaffold(
        backgroundColor: theme.accentColor,
        body: Center(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S.of(context).splash_name,
                      style: textStyle),
                ),
                Padding(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryTextTheme.headline1.color
                    )
                  ),
                  padding: EdgeInsets.only(top: 48)
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            )
        )
    );
  }
}
