part of 'ticket_bloc.dart';

class TicketState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TicketInitialState extends TicketState {}

class LoadingState extends TicketState {}

class SuccessState extends TicketState {
  List<TourBus> buyticket;
  List<Seat> seat;
  List<PickUp> pickup;
  List<Discount> discount;
  List<Order> order;
  List<Address> address;
  SuccessState(
      {this.buyticket,
      this.seat,
      this.pickup,
      this.discount,
      this.order,
      this.address});
}

class FailureState extends TicketState {
  String msg;

  FailureState({this.msg});
}
