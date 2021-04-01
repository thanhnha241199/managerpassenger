import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/rental/model/rental.dart';

import 'package:managepassengercar/repository/rental_repository.dart';

part 'rental_event.dart';

part 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  RentalRepository rentalRepository;
  RentalBloc(RentalState initialState, this.rentalRepository)
      : super(initialState);

  @override
  Stream<RentalState> mapEventToState(RentalEvent event) async* {
    // TODO: implement mapEventToState
    if (event is DoFetchEventData) {
      try {
        yield LoadingState();
        var rental = await rentalRepository.fetchRental(event.id);
        yield SuccessStateOrder(rental: rental);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (event is OrderRentalEvent) {
      try {
        yield LoadingState();
        var buyticket = await rentalRepository.addOrder(
            event.uid,
            event.name,
            event.phone,
            event.email,
            event.locationstart,
            event.locationend,
            event.timestart,
            event.timeend,
            event.quantyseat,
            event.quanticus,
            event.type,
            event.note);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "Order failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
  }
}
