part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginUserSuccess extends LoginState {}

class LoginEmployeeSuccess extends LoginState {}

class LoginNull extends LoginState {}

class LoginFailture extends LoginState {
  final String error;

  const LoginFailture({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailture { error: $error }';
}

class ForgetSuccess extends LoginState {}

class ForgetConfirm extends LoginState {}

class ForgetReConfirm extends LoginState {}

class ForgetFailure extends LoginState {
  final String error;

  const ForgetFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' ForgetFailture { error: $error }';
}
