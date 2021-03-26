import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/utils/validators.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent registerEvent) async* {
    if (registerEvent is RegisterEventEmailChanged) {
      yield state.cloneAndUpdate(
        isValidEmail: Validators.isValidEmail(registerEvent.email),
      );
    } else if (registerEvent is RegisterEventPasswordChanged) {
      yield state.cloneAndUpdate(
        isValidPassword: Validators.isValidPassword(registerEvent.password),
      );
    } else if (registerEvent is RegisterEventPressed) {
      yield RegisterState.loading();
      try {
        final otp = await userRepository.confirmUser(
            name: registerEvent.name,
            username: registerEvent.email,
            password: registerEvent.password,
            phone: registerEvent.phone);
        authenticationBloc.add(Confirm(otp: otp));
        yield RegisterState.confirm();
      } catch (exception) {
        yield RegisterState.failure();
      }
    }
    if (registerEvent is ConfirmOTP) {
      yield RegisterState.loading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (registerEvent.otp == prefs.getString("otp")) {
        var res = await userRepository.createUser(
            username: prefs.getString('email'),
            password: prefs.getString('password'),
            name: prefs.getString('name'),
            phone: prefs.getString('phone'));
        print(res);
        yield RegisterState.confirmSuccess();
      } else {
        yield RegisterState.confirmFailure();
      }
    }
  }
}
