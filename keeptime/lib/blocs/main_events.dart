import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();

  List<Object> get props => [];
}

class PreferencesButtonPressed extends MainEvent {}
