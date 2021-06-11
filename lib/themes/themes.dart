import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
  );
  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
    if (state.brightness == Brightness.dark) {
      print("dart");
    } else {
      print("light");
    }
  }
}
