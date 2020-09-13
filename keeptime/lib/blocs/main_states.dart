import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainState extends Equatable {
  const MainState();

  List<Object> get props => [];
}

class HomeLog extends MainState {}

class HomePreferences extends MainState {}

class HomeWorkspaces extends MainState {}
