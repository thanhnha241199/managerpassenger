part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final User user;

  const LoggedIn({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: ${user.username}}';
}

class Confirm extends AuthenticationEvent {
  Otp otp;

  Confirm({@required this.otp});

  @override
  List<Object> get props => [otp];

  @override
  String toString() => 'Confirm { otp: ${otp.otp}}';
}

class LoggedOut extends AuthenticationEvent {}
