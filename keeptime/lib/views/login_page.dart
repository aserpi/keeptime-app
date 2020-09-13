import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keeptime/blocs/authentication_bloc.dart';
import 'package:keeptime/blocs/authentication_states.dart';
import 'package:keeptime/blocs/login_bloc.dart';
import 'package:keeptime/blocs/login_events.dart';
import 'package:keeptime/blocs/login_states.dart';
import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/network/exceptions.dart';
import 'package:keeptime/widgets/network_error_text.dart';
import 'package:keeptime/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      // Need a nested widget to use Scaffold.of
      body: _LoginPageBody(),
    );
  }
}

class _LoginPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // If necessary, show an error message when creating the page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BlocProvider.of<AuthenticationBloc>(context).state;
      if (state is! AuthenticationUnauthenticated) return;

      final error = (state as AuthenticationUnauthenticated).error;
      if (error == null) return;

      StatelessWidget errorText;
      if (error is UnauthorizedException) {
        errorText = Text(S.of(context).login_again);
      } else {
        errorText = NetworkErrorText(error);
      }

      Scaffold.of(context).showSnackBar(SnackBar(content: errorText));
    });

    return BlocProvider(
      child: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) => Stack(
                children: <Widget>[
                  if (state is LoginLoading) LinearProgressIndicator(),
                  Padding(
                    child: LoginForm(),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  )
                ],
              ),
          listener: (context, state) {
            if (state is LoginFailure) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(
                    content: NetworkErrorText(state.error),
                  ))
                  .closed
                  .then((_) => BlocProvider.of<LoginBloc>(context)
                      .add(LoginSnackbarDismissed()));
            }
          }),
      create: (context) {
        return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
      },
    );
  }
}
