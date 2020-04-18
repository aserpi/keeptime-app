import 'package:flutter/material.dart';

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
