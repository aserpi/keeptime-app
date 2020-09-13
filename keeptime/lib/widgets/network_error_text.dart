import 'package:flutter/material.dart';

import 'package:keeptime/generated/l10n.dart';
import 'package:keeptime/network/exceptions.dart';

class NetworkErrorText extends StatelessWidget {
  final NetworkException error;

  const NetworkErrorText(this.error, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorMessage;
    if(error is NoInternetException) {
      errorMessage = S.of(context).no_internet;
    } else if (error is NoServerException) {
      errorMessage = S.of(context).no_server;
    } else if (error is UnauthorizedException) {
      errorMessage = S.of(context).invalid_credentials;
    } else {
      errorMessage = S.of(context).unknown_error;
    }
    return Text(errorMessage);
  }
}
