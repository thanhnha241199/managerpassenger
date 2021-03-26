part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoFetchEvent extends EmployeeEvent {}
