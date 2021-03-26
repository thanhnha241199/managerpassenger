import 'dart:convert';

PickUp pickUpFromJson(String str) => PickUp.fromJson(json.decode(str));

String pickUpToJson(PickUp data) => json.encode(data.toJson());

class PickUp {
  PickUp({
    this.time,
    this.id,
    this.tourid,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  List<String> time;
  String id;
  String tourid;
  List<Address> address;
  DateTime createdAt;
  DateTime updatedAt;

  factory PickUp.fromJson(Map<String, dynamic> json) => PickUp(
        time: List<String>.from(json["time"].map((x) => x)),
        id: json["_id"],
        tourid: json["tourid"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "_id": id,
        "tourid": tourid,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Address {
  Address({
    this.id,
    this.title,
    this.address,
  });

  String id;
  String title;
  String address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        title: json["title"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "address": address,
      };
}
