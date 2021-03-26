part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ButtonFocused extends SettingEvent {}

class EmailUnfocused extends SettingEvent {}
