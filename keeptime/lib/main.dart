import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'authentication/authentication.dart';
import 'generated/l10n.dart';
import 'login/login.dart';
import 'splash/spash.dart';

void main() {
  BlocSupervisor.delegate = BlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc()
          ..add(AppStarted());
        },
      child: KeepTime(),
    ),
  );
}

class KeepTime extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (BuildContext context) => S.of(context).app_name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return SplashPage(); // TODO: home page
          } else if (state is AuthenticationUnauthenticated) {
            return LoginPage();
          } else {
            assert(state is AuthenticationUninitialized);
            return SplashPage();
          }
        },
      ),
    );
  }
}
