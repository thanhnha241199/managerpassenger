// To parse this JSON data, do
//
//     final tourBus = tourBusFromJson(jsonString);

import 'dart:convert';

TourBus tourBusFromJson(String str) => TourBus.fromJson(json.decode(str));

String tourBusToJson(TourBus data) => json.encode(data.toJson());

class TourBus {
  TourBus({
    this.id,
    this.locationstart,
    this.locationend,
    this.time,
    this.range,
    this.price,
    this.createdAt,
    this.sale,
    this.updatedAt,
  });

  String id;
  String locationstart;
  String locationend;
  String time;
  String range;
  String price;
  DateTime createdAt;
  String sale;
  DateTime updatedAt;

  factory TourBus.fromJson(Map<String, dynamic> json) => TourBus(
        id: json["_id"],
        locationstart: json["locationstart"],
        locationend: json["locationend"],
        time: json["time"],
        range: json["range"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        sale: json["sale"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationstart": locationstart,
        "locationend": locationend,
        "time": time,
        "range": range,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "sale": sale,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
