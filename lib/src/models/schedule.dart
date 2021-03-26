import 'dart:convert';
import 'package:managepassengercar/src/models/schedule_element.dart';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    this.id,
    this.idtour,
    this.locationstart,
    this.locationend,
    this.schedule,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String idtour;
  String locationstart;
  String locationend;
  List<ScheduleElement> schedule;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["_id"],
    idtour: json["idtour"],
    locationstart: json["locationstart"],
    locationend: json["locationend"],
    schedule: List<ScheduleElement>.from(json["schedule"].map((x) => ScheduleElement.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "idtour": idtour,
    "locationstart": locationstart,
    "locationend": locationend,
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
