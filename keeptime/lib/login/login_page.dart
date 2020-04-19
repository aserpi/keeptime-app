import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/exceptions.dart';
import '../authentication/authentication.dart';
import '../generated/l10n.dart';
import '../ui/error_text.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_events.dart';
import 'bloc/login_states.dart';
import 'login_form.dart';

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
      if(state is! AuthenticationUnauthenticated) return;

      final error = (state as AuthenticationUnauthenticated).error;
      if(error == null) return;

      StatelessWidget errorText;
      if(error is UnauthorizedException) {
        errorText = Text(S.of(context).login_again);
      } else {
        errorText = ErrorText(error);
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        content: errorText
      ));
    });

    return BlocProvider(
      child: BlocListener<LoginBloc, LoginState>(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                if(state is LoginLoading) LinearProgressIndicator(),
                Padding(
                  child: LoginForm(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                )
              ],
            );
          },
        ),
        listener: (context, state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: ErrorText(state.error),
            )).closed.then((_) => BlocProvider.of<LoginBloc>(context).add(
                LoginSnackbarDismissed()
            ));
          }
        }
      ),
      create: (context) {
        return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)
        );
      },
    );
  }
}
