// To parse this JSON data, do
//
//     final orderStatus = orderStatusFromJson(jsonString);

import 'dart:convert';

OrderStatus orderStatusFromJson(String str) =>
    OrderStatus.fromJson(json.decode(str));

String orderStatusToJson(OrderStatus data) => json.encode(data.toJson());

class OrderStatus {
  OrderStatus({
    this.success,
    this.msg,
    this.id,
  });

  bool success;
  String msg;
  String id;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        success: json["success"],
        msg: json["msg"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "id": id,
      };
}
