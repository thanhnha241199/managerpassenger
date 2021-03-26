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
