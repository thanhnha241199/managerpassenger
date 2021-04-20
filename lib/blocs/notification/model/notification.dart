// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    this.id,
    this.title,
    this.description,
    this.uid,
    this.time,
  });

  String id;
  String title;
  String description;
  String uid;
  DateTime time;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        uid: json["uid"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "uid": uid,
        "time": time.toIso8601String(),
      };
}
