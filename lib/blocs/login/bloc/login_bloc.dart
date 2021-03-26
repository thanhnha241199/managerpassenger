import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent loginEvent,
  ) async* {
    if (loginEvent is LoginButtonPressed) {
      yield LoginLoading();
      if (loginEvent.email.isEmpty || loginEvent.password.isEmpty) {
        yield LoginNull();
      } else {
        try {
          final user = await userRepository.authenticate(
            username: loginEvent.email,
            password: loginEvent.password,
          );
          authenticationBloc.add(LoggedIn(user: user));
          if (user.type == "1") {
            yield LoginUserSuccess();
          } else if (user.type == "0") {
            yield LoginEmployeeSuccess();
          }
        } catch (error) {
          yield LoginFailture(error: error.toString());
        }
      }
    }
    if (loginEvent is ForgetButtonPressed) {
      yield LoginLoading();
      if (loginEvent.email.isEmpty) {
        yield LoginNull();
      } else {
        try {
          final otp =
              await userRepository.confirmForget(username: loginEvent.email);
          authenticationBloc.add(Confirm(otp: otp));
          yield ForgetConfirm();
        } catch (error) {
          yield ForgetFailure(error: error.toString());
        }
      }
    }
    if (loginEvent is ReconfirmButtonPressed) {
      yield LoginLoading();
      if (loginEvent.email.isEmpty) {
        yield LoginNull();
      } else {
        try {
          final otp =
              await userRepository.confirmForget(username: loginEvent.email);
          authenticationBloc.add(Confirm(otp: otp));
          yield ForgetReConfirm();
        } catch (error) {
          yield ForgetFailure(error: error.toString());
        }
      }
    }
    if (loginEvent is ConfirmOTP) {
      yield LoginLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("confirm: ${loginEvent.otp == prefs.getString("otp")}");
      if (loginEvent.otp == prefs.getString("otp")) {
        yield ForgetConfirm();
      } else {
        yield ForgetFailure();
      }
    }
    if (loginEvent is ChangeButtonPressed) {
      yield LoginLoading();
      if (loginEvent.password.isEmpty) {
        yield LoginNull();
      } else {
        try {
          final otp = await userRepository.resetPassword(
              username: loginEvent.email, password: loginEvent.password);
          if (otp.success) {
            yield ForgetSuccess();
          }
        } catch (error) {
          yield ForgetFailure(error: error.toString());
        }
      }
    }
  }
}
