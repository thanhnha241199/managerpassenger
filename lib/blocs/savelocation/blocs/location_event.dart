part of 'location_bloc.dart';

class AddressEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoFetchEvent extends AddressEvent {}

class DoFetchAddressEvent extends AddressEvent {}

class UpdateEvent extends AddressEvent {
  final String id;
  final String name;
  final String address;

  UpdateEvent({@required this.id, @required this.name, @required this.address});

  @override
  List<Object> get props => [id, name, address];
}

class AddEvent extends AddressEvent {
  final String name;
  final String address;

  AddEvent({@required this.name, @required this.address});

  @override
  List<Object> get props => [name, address];
}

class DeleteEvent extends AddressEvent {
  final String id;

  DeleteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
