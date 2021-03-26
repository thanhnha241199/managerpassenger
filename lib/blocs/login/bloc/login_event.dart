part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}

class ChangeButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const ChangeButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'ChangeButtonPressed { email: $email, password: $password }';
}

class ForgetButtonPressed extends LoginEvent {
  final String email;

  const ForgetButtonPressed({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'ForgetButtonPressed { email: $email}';
}

class ReconfirmButtonPressed extends LoginEvent {
  final String email;

  const ReconfirmButtonPressed({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'ReconfirmtButtonPressed { email: $email}';
}

class ConfirmOTP extends LoginEvent {
  final String otp;

  const ConfirmOTP({
    @required this.otp,
  });

  @override
  List<Object> get props => [otp];

  @override
  String toString() {
    return 'ConfirmOTPPressed, OTP: $otp';
  }
}
