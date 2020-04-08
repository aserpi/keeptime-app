import 'package:flutter/material.dart';
import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/ui/password_form_field.dart';
import 'package:string_validator/string_validator.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  FocusNode _passwordFocus;
  FocusNode _usernameFocus;
  FocusNode _serverFocus;

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: true,
      autovalidate: true,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: S.of(context).username,
        isDense: true,
        labelText: S.of(context).username,
      ),
      focusNode: _usernameFocus,
      onFieldSubmitted: (_) {
        _usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );

    final passwordField = FormFieldPadding(
      child: PasswordFormField(
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
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: S.of(context).server,
        isDense: true,
        labelText: S.of(context).server,
      ),
      focusNode: _serverFocus,
      keyboardType: TextInputType.url,
      onFieldSubmitted: (_) {
        _serverFocus.unfocus();
      },
      textInputAction: TextInputAction.done,
      validator: (String value) {
        return value.isNotEmpty && !isURL(value)
            ? S.of(context).server_invalid
            : null;
      },
    ));

    final rememberSwitch = FormFieldPadding(
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        onChanged: (bool value) {
          setState(() {
            rememberMe = value;
          });
        },
        title: Text(S.of(context).remember_me),
        value: rememberMe,
      ),
    );

    final submitButton = FormFieldPadding(
      child: RaisedButton(
        child: Text(
          S.of(context).login.toUpperCase(),
        ),
        onPressed: null,
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          usernameField,
          passwordField,
          serverField,
          rememberSwitch,
          submitButton,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordFocus.dispose();
    _serverFocus.dispose();
    _usernameFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordFocus = FocusNode();
    _serverFocus = FocusNode();
    _usernameFocus = FocusNode();
  }
}

class FormFieldPadding extends StatelessWidget {
  final Widget child;

  const FormFieldPadding({Key key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
      key: key,
      padding: EdgeInsets.only(top: 8),
    );
  }
}
