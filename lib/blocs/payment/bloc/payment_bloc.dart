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
          yield SuccessState();
        } else {
          print("AAA");
        }
      } catch (error) {
        print(error.toString());
        yield FailureState(msg: error.toString());
      }
    }
  }
}
