part of 'rental_bloc.dart';

class RentalEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoFetchEventData extends RentalEvent {
  final String id;

  DoFetchEventData({this.id});
}

class OrderRentalEvent extends RentalEvent {
  final String uid;
  final String name;
  final String phone;
  final String email;

  final String timestart;
  final String timeend;
  final String locationstart;
  final String locationend;
  final String quantyseat;
  final String quanticus;
  final String type;
  final String note;

  OrderRentalEvent(
      {this.uid,
      this.name,
      this.phone,
      this.email,
      this.timestart,
      this.timeend,
      this.locationstart,
      this.locationend,
      this.quantyseat,
      this.quanticus,
      this.type,
      this.note});
}
