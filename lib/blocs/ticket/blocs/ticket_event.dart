part of 'ticket_bloc.dart';

class TicketEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoFetchEvent extends TicketEvent {
  final String idtourbus;
  final String idseat;
  DoFetchEvent({this.idtourbus, this.idseat});
}

class OrderEvent extends TicketEvent {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String qr;
  final String paymentType;
  final String idtour;
  final String time;
  final String locationstart;
  final String quantyseat;
  final String seat;
  final String price;

  final String totalprice;

  OrderEvent({
    this.uid,
    this.qr,
    this.name,
    this.phone,
    this.email,
    this.idtour,
    this.time,
    this.locationstart,
    this.quantyseat,
    this.seat,
    this.price,
    this.totalprice,
    this.paymentType,
  });
}

class AddNoti extends TicketEvent {
  final String id;
  final String title;
  final String description;
  AddNoti({this.id, this.title, this.description});
}

class ReviewTourbus extends TicketEvent {
  final String id;
  final String rating;
  final String description;
  ReviewTourbus({this.id, this.rating, this.description});
}

class ChangeOrder extends TicketEvent {
  final String id;
  final String status;
  ChangeOrder({this.id, this.status});
}

class SendNoti extends TicketEvent {
  final String title;
  final String token;
  final String body;

  SendNoti({this.title, this.token, this.body});
}

class SendMail extends TicketEvent {
  final String name;
  final String phone;
  final String email;
  final String idtour;
  final String time;
  final String locationstart;
  final String quantyseat;
  final String seat;
  final String price;
  final String orderID;
  final String totalprice;

  SendMail(
      {this.name,
      this.phone,
      this.email,
      this.idtour,
      this.time,
      this.locationstart,
      this.quantyseat,
      this.seat,
      this.price,
      this.orderID,
      this.totalprice});
}
