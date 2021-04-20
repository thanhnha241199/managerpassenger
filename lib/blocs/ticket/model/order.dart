// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.tour,
    this.location,
    this.timetour,
    this.quantity,
    this.status,
    this.qr,
    this.seat,
    this.price,
    this.totalprice,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String uid;
  String name;
  String email;
  String phone;
  String tour;
  String location;
  String timetour;
  String quantity;
  String status;
  String qr;
  String seat;
  String price;
  String totalprice;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        tour: json["tour"],
        location: json["location"],
        timetour: json["timetour"],
        quantity: json["quantity"],
        status: json["status"],
        qr: json["qr"],
        seat: json["seat"],
        price: json["price"],
        totalprice: json["totalprice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "tour": tour,
        "location": location,
        "timetour": timetour,
        "quantity": quantity,
        "status": status,
        "qr": qr,
        "seat": seat,
        "price": price,
        "totalprice": totalprice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
