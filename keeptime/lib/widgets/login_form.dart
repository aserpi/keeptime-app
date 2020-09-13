import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';

import 'package:keeptime/blocs/login_bloc.dart';
import 'package:keeptime/blocs/login_events.dart';
import 'package:keeptime/blocs/login_states.dart';
import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/widgets/form_field_padding.dart';
import 'package:keeptime/widgets/password_form_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _serverController = TextEditingController();

  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _serverFocus;

  submit() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
      server: _serverController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: true,
      autovalidate: true,
      controller: _emailController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: S.of(context).email,
        isDense: true,
        labelText: S.of(context).email,
      ),
      focusNode: _emailFocus,
      onFieldSubmitted: (_) {
        _emailFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );

    final passwordField = FormFieldPadding(
      child: PasswordFormField(
        controller: _passwordController,
        focusNode: _passwordFocus,
        onFieldSubmitted: (_) {
          _passwordFocus.unfocus();
          FocusScope.of(context).requestFocus(_serverFocus);
        },
        textInputAction: TextInputAction.next,
      ),
    );

    final serverField = FormFieldPadding(
      child: TextFormField(
        autovalidate: true,
        controller: _serverController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: S.of(context).server,
          isDense: true,
          labelText: S.of(context).server,
        ),
        focusNode: _serverFocus,
        keyboardType: TextInputType.url,
        onFieldSubmitted: (_) {submit();},
        textInputAction: TextInputAction.done,
        validator: (String value) {
          return value.isNotEmpty && !isURL(value)
              ? S.of(context).server_invalid : null;
        },
      )
    );

    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                emailField,
                passwordField,
                serverField,
                FormFieldPadding(
                  child: RaisedButton(
                    child: Text(S.of(context).login.toUpperCase()),
                    onPressed: state is LoginLoading
                        ? null : submit
                  )
                )
              ],
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _serverController.dispose();
    _emailController.dispose();

    _passwordFocus.dispose();
    _serverFocus.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordFocus = FocusNode();
    _serverFocus = FocusNode();
    _emailFocus = FocusNode();
  }
}
