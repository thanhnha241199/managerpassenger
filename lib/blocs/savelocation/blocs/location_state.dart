part of 'location_bloc.dart';

class AddressState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialState extends AddressState {}

class LoadingState extends AddressState {}

class SuccessState extends AddressState {
  List<Address> address;
  List<AddressModel> addressmodel;
  SuccessState({this.address, this.addressmodel});
}

class FailureState extends AddressState {
  String msg;

  FailureState({this.msg});
}

class UpdateLoadingState extends AddressState {}

class UpdateNullState extends AddressState {}

class UpdateSuccessState extends AddressState {
  String success;

  UpdateSuccessState({this.success});
}

class UpdateFailureState extends AddressState {
  String msg;

  UpdateFailureState({this.msg});
}

class AddLoadingState extends AddressState {}

class AddNullState extends AddressState {}

class AddSuccessState extends AddressState {
  String success;

  AddSuccessState({this.success});
}

class AddFailureState extends AddressState {
  String msg;

  AddFailureState({this.msg});
}

class DeleteLoadingState extends AddressState {}

class DeleteSuccessState extends AddressState {
  String success;

  DeleteSuccessState({this.success});
}

class DeleteFailureState extends AddressState {
  String msg;

  DeleteFailureState({this.msg});
}
