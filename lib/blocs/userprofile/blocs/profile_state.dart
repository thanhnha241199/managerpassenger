part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  ProfileUser profile;

  SuccessProfileState({this.profile});
}

class FailureProfileState extends ProfileState {
  String msg;

  FailureProfileState({this.msg});
}
class UpdateLoadingProfileState extends ProfileState {}

class UpdateProfileState extends ProfileState {
  ProfileUser profile;

  UpdateProfileState({this.profile});
}

class UpdateFailureProfileState extends ProfileState {
  String msg;

  UpdateFailureProfileState({this.msg});
}