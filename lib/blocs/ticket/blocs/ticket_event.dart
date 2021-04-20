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
  final String idtour;
  final String time;
  final String locationstart;
  final String quantyseat;
  final String seat;
  final String price;
  final String totalprice;

  OrderEvent(
      {this.uid,
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
      this.totalprice});
}

class SendNoti extends TicketEvent {
  final String tokenid;
  SendNoti({this.tokenid});
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
      this.totalprice});
}
