// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get app_name {
    return Intl.message(
      'KeepTime',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  String get invalid_credentials {
    return Intl.message(
      'Invalid credentials',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  String get no_internet {
    return Intl.message(
      'No internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  String get no_server {
    return Intl.message(
      'Cannot connect to server',
      name: 'no_server',
      desc: '',
      args: [],
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  String get server {
    return Intl.message(
      'Server',
      name: 'server',
      desc: '',
      args: [],
    );
  }

  String get server_invalid {
    return Intl.message(
      'Not a valid URL',
      name: 'server_invalid',
      desc: '',
      args: [],
    );
  }

  String get splash_name {
    return Intl.message(
      'Keep\nTime',
      name: 'splash_name',
      desc: '',
      args: [],
    );
  }

  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}