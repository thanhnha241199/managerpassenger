part of 'rental_bloc.dart';

class RentalState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RentalInitialState extends RentalState {}

class LoadingState extends RentalState {}

class SuccessState extends RentalState {}

class SuccessStateOrder extends RentalState {
  List<RentalOrder> rental;
  SuccessStateOrder({this.rental});
}

class FailureState extends RentalState {
  String msg;

  FailureState({this.msg});
}
