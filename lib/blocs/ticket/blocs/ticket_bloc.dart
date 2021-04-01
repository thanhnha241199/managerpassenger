import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/ticket.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/ticket_repository.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/seat.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository ticketRepository;

  TicketBloc(TicketState initialState, this.ticketRepository)
      : super(initialState);

  @override
  Stream<TicketState> mapEventToState(TicketEvent ticketEvent) async* {
    // TODO: implement mapEventToState
    if (ticketEvent is DoFetchEvent) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.fetchTourbus();
        var pickup = await ticketRepository.fetchData(ticketEvent.idtourbus);
        var seat = await ticketRepository.fetchSeat(ticketEvent.idseat);
        yield SuccessState(buyticket: buyticket, pickup: pickup, seat: seat);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (ticketEvent is OrderEvent) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.addOrder(
            ticketEvent.uid,
            ticketEvent.name,
            ticketEvent.phone,
            ticketEvent.email,
            ticketEvent.idtour,
            ticketEvent.time,
            ticketEvent.locationstart,
            ticketEvent.quantyseat,
            ticketEvent.seat,
            ticketEvent.price,
            ticketEvent.totalprice);
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
