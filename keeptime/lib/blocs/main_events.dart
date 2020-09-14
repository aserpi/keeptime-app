import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();

  List<Object> get props => [];
}

class LogButtonPressed extends MainEvent {}

class PreferencesButtonPressed extends MainEvent {}

class WorkspacesButtonPressed extends MainEvent {}
