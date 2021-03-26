part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEventEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEventEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RegisterEventEmailChanged, email :$email';
}

class RegisterEventPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterEventPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RegisterEventPasswordChanged, password: $password';
}

class RegisterEventPressed extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  const RegisterEventPressed(
      {@required this.email,
      @required this.password,
      @required this.name,
      @required this.phone});

  @override
  List<Object> get props => [email, password, name, phone];

  @override
  String toString() {
    return 'RegisterEventPressed, email: $email, password: $password, name: $name, phone: $phone ';
  }
}

class ConfirmOTP extends RegisterEvent {
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
