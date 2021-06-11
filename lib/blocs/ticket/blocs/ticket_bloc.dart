import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/ticket_repository.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/seat.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository ticketRepository;

  TicketBloc(TicketState initialState, this.ticketRepository)
      : super(initialState);

  @override
  Stream<TicketState> mapEventToState(TicketEvent ticketEvent) async* {
    if (ticketEvent is DoFetchEvent) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.fetchTourbus();
        var pickup = await ticketRepository.fetchData(ticketEvent.idtourbus);
        var seat = await ticketRepository.fetchSeat(ticketEvent.idseat);
        var discount = await ticketRepository.fetchDiscount();
        var address = await ticketRepository.fetchAddress();
        var order = await ticketRepository.fetchOrder();
        yield SuccessState(
            buyticket: buyticket,
            pickup: pickup,
            seat: seat,
            discount: discount,
            order: order,
            address: address);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (ticketEvent is SendNoti) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.sendNoti(
            ticketEvent.token, ticketEvent.title, ticketEvent.body);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "Noti failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (ticketEvent is ChangeOrder) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.changeorder(
            ticketEvent.id, ticketEvent.status);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "change failed");
        }
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
          ticketEvent.qr,
          ticketEvent.idtour,
          ticketEvent.time,
          ticketEvent.locationstart,
          ticketEvent.quantyseat,
          ticketEvent.seat,
          ticketEvent.price,
          ticketEvent.totalprice,
          ticketEvent.paymentType,
        );
        if (buyticket.success == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          print(buyticket.id);
          pref.setString("orderID", buyticket.id).whenComplete(() {
            print("Save success");
          });
          yield SuccessState();
        } else {
          yield FailureState(msg: "Order failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (ticketEvent is AddNoti) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.addNoti(
            ticketEvent.id, ticketEvent.title, ticketEvent.description);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "Noti failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (ticketEvent is SendMail) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.sendMail(
            ticketEvent.name,
            ticketEvent.phone,
            ticketEvent.email,
            ticketEvent.idtour,
            ticketEvent.time,
            ticketEvent.locationstart,
            ticketEvent.quantyseat,
            ticketEvent.seat,
            ticketEvent.price,
            ticketEvent.orderID,
            ticketEvent.totalprice);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "Sendmail failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }

    if (ticketEvent is ReviewTourbus) {
      try {
        yield LoadingState();
        var buyticket = await ticketRepository.reviewTourBus(
            ticketEvent.id, ticketEvent.rating, ticketEvent.description);
        if (buyticket == "true") {
          yield SuccessState();
        } else {
          yield FailureState(msg: "Review failed");
        }
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
  }
}
