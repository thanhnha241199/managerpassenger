part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool confirmSuccess;
  final bool confirmFailure;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidEmailAndPassword =>
      isValidEmail && isValidPassword; //how to validate ?

  RegisterState({
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isSubmitting,
    @required this.confirmSuccess,
    @required this.confirmFailure,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.initial() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      confirmFailure: false,
      confirmSuccess: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      confirmFailure: false,
      confirmSuccess: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      confirmFailure: false,
      confirmSuccess: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.confirm() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      confirmFailure: false,
      confirmSuccess: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory RegisterState.confirmSuccess() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      confirmFailure: false,
      confirmSuccess: true,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory RegisterState.confirmFailure() {
    return RegisterState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      confirmFailure: true,
      confirmSuccess: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState cloneAndUpdate({
    bool isValidEmail,
    bool isValidPassword,
  }) {
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isSubmitting: false,
      confirmFailure: false,
      confirmSuccess: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool confirmFailure,
    bool confirmSuccess,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      confirmFailure: confirmFailure ?? this.confirmFailure,
      confirmSuccess: confirmSuccess ?? this.confirmSuccess,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isValidEmail: $isValidEmail,
      isValidPassword: $isValidPassword,      
      isSubmitting: $isSubmitting,
      confirmFailure: $confirmFailure,      
      confirmSuccess: $confirmSuccess,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
