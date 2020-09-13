import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserPreferencesState extends Equatable {
  const UserPreferencesState();

  List<Object> get props => [];
}

class LoggingOut extends UserPreferencesState {}

class InitialUserPreferencesState extends UserPreferencesState {}

class LogoutSuccess extends UserPreferencesState {}
