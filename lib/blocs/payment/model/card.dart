// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.id,
    this.uid,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String uid;
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  DateTime createdAt;
  DateTime updatedAt;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["_id"],
        uid: json["uid"],
        cardNumber: json["cardNumber"],
        expiryDate: json["expiryDate"],
        cardHolderName: json["cardHolderName"],
        cvvCode: json["cvvCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "cardHolderName": cardHolderName,
        "cvvCode": cvvCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
