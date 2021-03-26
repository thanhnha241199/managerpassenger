import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/employee_repository.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/profile_user.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/models/seat.dart';
import 'package:managepassengercar/src/views/profile/profile.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc(EmployeeState initialState, this.employeeRepository)
      : super(initialState);

  final EmployeeRepository employeeRepository;

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent employeeEvent) async* {
    // TODO: implement mapEventToState
    if (employeeEvent is DoFetchEvent) {
      try {
        yield LoadingState();
        var tourbus = await employeeRepository.fetchTourbus();
        var pickup = await employeeRepository.fetchPickUp();
        var schedule = await employeeRepository.fetchSchedule();
        var seat = await employeeRepository.fetchSeat();
        var profile = await employeeRepository.fetchProfileUser();
        yield SuccessState(
            toubus: tourbus,
            pickup: pickup,
            schedule: schedule,
            seat: seat,
            profileUser: profile);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
  }
}
