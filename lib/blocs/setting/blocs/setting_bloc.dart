import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc(SettingState initialState) : super(initialState);

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
