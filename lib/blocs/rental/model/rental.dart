// To parse this JSON data, do
//
//     final rentalOrder = rentalOrderFromJson(jsonString);

import 'dart:convert';

RentalOrder rentalOrderFromJson(String str) =>
    RentalOrder.fromJson(json.decode(str));

String rentalOrderToJson(RentalOrder data) => json.encode(data.toJson());

class RentalOrder {
  RentalOrder({
    this.id,
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.timestart,
    this.timeend,
    this.locationstart,
    this.locationend,
    this.quantityseat,
    this.quanticus,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String uid;
  String name;
  String phone;
  String email;
  DateTime timestart;
  DateTime timeend;
  String locationstart;
  String locationend;
  String quantityseat;
  String quanticus;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  factory RentalOrder.fromJson(Map<String, dynamic> json) => RentalOrder(
        id: json["_id"],
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        timestart: DateTime.parse(json["timestart"]),
        timeend: DateTime.parse(json["timeend"]),
        locationstart: json["locationstart"],
        locationend: json["locationend"],
        quantityseat: json["quantityseat"],
        quanticus: json["quanticus"],
        note: json["note"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "name": name,
        "phone": phone,
        "email": email,
        "timestart": timestart.toIso8601String(),
        "timeend": timeend.toIso8601String(),
        "locationstart": locationstart,
        "locationend": locationend,
        "quantityseat": quantityseat,
        "quanticus": quanticus,
        "note": note,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
