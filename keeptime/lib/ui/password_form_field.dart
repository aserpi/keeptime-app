import 'package:flutter/material.dart';
import 'package:keeptime/generated/l10n.dart';

class PasswordFormField extends StatefulWidget {
  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isConfirmation;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: S.of(context).password,
        isDense: true,
        labelText: S.of(context).password,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
      enableSuggestions: false,
      keyboardType: TextInputType.text,
      obscureText: !isPasswordVisible,
    );
  }
}
