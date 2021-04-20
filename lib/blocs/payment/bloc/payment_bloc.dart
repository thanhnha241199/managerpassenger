import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/repository/payment_repository.dart';
import 'package:managepassengercar/repository/rental_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:managepassengercar/blocs/payment/model/card.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentRepository paymentRepository;
  PaymentBloc(PaymentState initialState, this.paymentRepository)
      : super(initialState);
  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    // TODO: implement mapEventToState
    if (event is DoFetchEvent) {
      yield LoadingState();
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        var card = await paymentRepository.fetchCard(pref.getString('id'));
        yield SuccessState(card: card);
      } catch (e) {
        print(e.toString());
        yield FailureState(msg: e.toString());
      }
    }
    if (event is DeleteEvent) {
      yield LoadingState();
      try {
        var msg = await paymentRepository.deleteCard(event.id);
        if (msg == "true") {
          yield AddSuccessState();
          yield LoadingState();
          try {
            SharedPreferences pref = await SharedPreferences.getInstance();
            var card = await paymentRepository.fetchCard(pref.getString('id'));
            yield SuccessState(card: card);
          } catch (e) {
            print(e.toString());
            yield FailureState(msg: e.toString());
          }
        } else {
          yield FailureState(msg: "error");
        }
      } catch (e) {
        print(e.toString());
        yield FailureState(msg: e.toString());
      }
    }
    if (event is AddEvent) {
      yield LoadingState();
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String msg = await paymentRepository.addCard(
            event.cardNumber,
            event.expiryDate,
            event.cardHolderName,
            event.cvvCode,
            event.showBackView,
            pref.getString('id'));
        if (msg == "true") {
          yield AddSuccessState();
          yield LoadingState();
          try {
            SharedPreferences pref = await SharedPreferences.getInstance();
            var card = await paymentRepository.fetchCard(pref.getString('id'));
            yield SuccessState(card: card);
          } catch (e) {
            print(e.toString());
            yield FailureState(msg: e.toString());
          }
        } else {
          yield FailureState(msg: "error");
        }
      } catch (error) {
        print(error.toString());
        yield FailureState(msg: error.toString());
      }
    }
    if (event is OrderEvent) {
      try {
        yield LoadingState();
        var buyticket = await paymentRepository.addOrder(
            event.uid,
            event.name,
            event.phone,
            event.email,
            event.idtour,
            event.time,
            event.locationstart,
            event.quantyseat,
            event.seat,
            event.price,
            event.totalprice);
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
