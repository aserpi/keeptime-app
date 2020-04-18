import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeptime/login/bloc/login_events.dart';

import '../authentication/authentication.dart';
import '../generated/l10n.dart';
import '../ui/error_text.dart';
import 'bloc/login_bloc.dart';
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
      body: BlocProvider(
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
      ),
    );
  }
}
