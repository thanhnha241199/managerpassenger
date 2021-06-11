part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmployeeInitialState extends EmployeeState {}

class LoadingState extends EmployeeState {}

class AddLoadingState extends EmployeeState {}

class SuccessState extends EmployeeState {
  List<TourBus> toubus;
  List<PickUp> pickup;
  List<Schedule> schedule;
  List<Seat> seat;

  ProfileUser profileUser;
  List<ListOrder> listorder;
  SuccessState(
      {this.toubus,
      this.pickup,
      this.schedule,
      this.seat,
      this.profileUser,
      this.listorder});
}

class FailureState extends EmployeeState {
  String msg;

  FailureState({this.msg});
}
