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
    this.review,
    this.driverid,
    this.shuttle,
    this.supportid,
    this.carid,
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
  List<Review> review;
  String driverid;
  String shuttle;
  String supportid;
  String carid;

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
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
        driverid: json["driverid"],
        shuttle: json["shuttle"],
        supportid: json["supportid"],
        carid: json["carid"],
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
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
        "driverid": driverid,
        "shuttle": shuttle,
        "supportid": supportid,
        "carid": carid,
      };
}

class Review {
  Review({
    this.id,
    this.rating,
    this.description,
  });

  String id;
  String rating;
  String description;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        rating: json["rating"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rating": rating,
        "description": description,
      };
}
