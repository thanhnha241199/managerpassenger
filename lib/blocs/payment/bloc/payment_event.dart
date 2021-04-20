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

class DeleteEvent extends PaymentEvent {
  final String id;
  DeleteEvent({this.id});
}

class OrderEvent extends PaymentEvent {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String idtour;
  final String time;
  final String locationstart;
  final String quantyseat;
  final String seat;
  final String price;
  final String totalprice;

  OrderEvent(
      {this.uid,
      this.name,
      this.phone,
      this.email,
      this.idtour,
      this.time,
      this.locationstart,
      this.quantyseat,
      this.seat,
      this.price,
      this.totalprice});
}
