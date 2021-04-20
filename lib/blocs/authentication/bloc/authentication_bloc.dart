import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/register/model/otp.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/models/api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = false;
      try {
        seen = (prefs.getBool('seen') ?? false);
      } catch (e) {
        print(e);
      }
      if (seen) {
        yield AuthenticationUninitialized();
        await Future.delayed(Duration(milliseconds: 3000));
        final bool hasToken = await userRepository.hasToken();
        final bool checktype = await userRepository.checkType();
        if (hasToken) {
          if (checktype) {
            yield AuthenticationAuthenticatedUser();
          } else {
            yield AuthenticationAuthenticatedEmployee();
          }
        } else {
          yield AuthenticationUnauthenticated();
        }
      } else {
        await prefs.setBool('seen', true);
        yield AuthenticationInitialized();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(user: event.user);
      if (event.user.type == "1") {
        yield AuthenticationAuthenticatedUser();
      } else if (event.user.type == "0") {
        yield AuthenticationAuthenticatedEmployee();
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken(id: 0);
      await userRepository.deleteData();
      yield AuthenticationUnauthenticated();
    }
  }
}
