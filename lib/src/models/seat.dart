import 'dart:convert';

Seat seatFromJson(String str) => Seat.fromJson(json.decode(str));

String seatToJson(Seat data) => json.encode(data.toJson());

class Seat {
  Seat({
    this.id,
    this.idtour,
    this.floors1,
    this.floors2,
  });

  String id;
  String idtour;
  List<String> floors1;

  List<String> floors2;


  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    id: json["_id"],
    idtour: json["idtour"],
    floors1: List<String>.from(json["floors1"].map((x) => x)),
    floors2: List<String>.from(json["floors1"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "idtour": idtour,
    "floors1": List<dynamic>.from(floors1.map((x) => x)),
    "floors2": List<dynamic>.from(floors2.map((x) => x)),
  };
}
