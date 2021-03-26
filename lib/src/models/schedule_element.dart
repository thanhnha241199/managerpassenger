class ScheduleElement {
  ScheduleElement({
    this.id,
    this.time,
    this.location,
    this.address,
  });

  String id;
  String time;
  String location;
  String address;

  factory ScheduleElement.fromJson(Map<String, dynamic> json) => ScheduleElement(
    id: json["_id"],
    time: json["time"],
    location: json["location"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "time": time,
    "location": location,
    "address": address,
  };
}