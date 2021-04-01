part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoFetchEvent extends PaymentEvent {}

class AddEvent extends PaymentEvent {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String showBackView;
  final String id;

  AddEvent(
      {this.cardNumber,
      this.cardHolderName,
      this.cvvCode,
      this.expiryDate,
      this.id,
      this.showBackView});
}
