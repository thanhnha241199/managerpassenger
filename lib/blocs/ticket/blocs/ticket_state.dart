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

  SuccessState({this.buyticket, this.seat, this.pickup});
}

class FailureState extends TicketState {
  String msg;

  FailureState({this.msg});
}
