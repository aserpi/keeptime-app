import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;

  const PasswordFormField({
    Key key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction
  }) : super(key: key);

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
      controller: widget.controller,
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
      focusNode: widget.focusNode,
      keyboardType: TextInputType.text,
      obscureText: !isPasswordVisible,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
    );
  }
}
