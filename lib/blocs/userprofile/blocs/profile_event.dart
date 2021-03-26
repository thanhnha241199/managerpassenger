part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DoFetchEvent extends ProfileEvent {
  String token;

  DoFetchEvent({this.token});
}

class UpdateEvent extends ProfileEvent {
  final String id;
  final String name;
  final String phone;
  final String image;
  final String token;

  UpdateEvent(
      {@required this.id,
      @required this.name,
      @required this.phone,
      @required this.image, this.token});

  @override
  List<Object> get props => [id, name, phone, image, token];
}
