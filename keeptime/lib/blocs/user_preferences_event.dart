import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserPreferencesEvent extends Equatable {
  const UserPreferencesEvent();

  List<Object> get props => [];
}

class LogoutButtonPressed extends UserPreferencesEvent {}

class LogoutFailed extends UserPreferencesEvent {}
