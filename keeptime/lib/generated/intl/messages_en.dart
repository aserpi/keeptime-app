// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "app_name" : MessageLookupByLibrary.simpleMessage("KeepTime"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "invalid_credentials" : MessageLookupByLibrary.simpleMessage("Invalid credentials"),
    "log" : MessageLookupByLibrary.simpleMessage("Log"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "login_again" : MessageLookupByLibrary.simpleMessage("Please log in again"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "logout_info" : MessageLookupByLibrary.simpleMessage("You will be logged out from the application"),
    "no_internet" : MessageLookupByLibrary.simpleMessage("No internet connection"),
    "no_server" : MessageLookupByLibrary.simpleMessage("Cannot connect to server"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "preferences" : MessageLookupByLibrary.simpleMessage("Settings"),
    "remember_me" : MessageLookupByLibrary.simpleMessage("Remember me"),
    "server" : MessageLookupByLibrary.simpleMessage("Server"),
    "server_invalid" : MessageLookupByLibrary.simpleMessage("Not a valid URL"),
    "splash_name" : MessageLookupByLibrary.simpleMessage("Keep\nTime"),
    "unknown_error" : MessageLookupByLibrary.simpleMessage("Unknown error"),
    "user_preferences" : MessageLookupByLibrary.simpleMessage("User settings"),
    "user_preferences_info" : MessageLookupByLibrary.simpleMessage("Email, password and logout"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "workspaces" : MessageLookupByLibrary.simpleMessage("Workspaces")
  };
}
