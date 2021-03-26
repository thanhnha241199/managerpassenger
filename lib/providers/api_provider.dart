import 'dart:convert';

import 'package:http/http.dart' as http;

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
    this.updatedAt,
    this.v,
  });

  String id;
  String locationstart;
  String locationend;
  String time;
  String range;
  String price;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory TourBus.fromJson(Map<String, dynamic> json) => TourBus(
        id: json["_id"],
        locationstart: json["locationstart"],
        locationend: json["locationend"],
        time: json["time"],
        range: json["range"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationstart": locationstart,
        "locationend": locationend,
        "time": time,
        "range": range,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

Future<List<TourBus>> getCommentsFromApi() async {
  final url =
      "https://managerpassenger.herokuapp.com/gettourbus";
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      final List<TourBus> comments = responseData.map((comment) {
        return TourBus(
          id: comment["_id"],
          locationstart: comment["locationstart"],
          locationend: comment["locationend"],
          time: comment["time"],
          range: comment["range"],
          price: comment["price"],
          createdAt: DateTime.parse(comment["createdAt"]),
          updatedAt: DateTime.parse(comment["updatedAt"]),
          v: comment["__v"],
        );
      }).toList();
      return comments;
    } else {
      return List<TourBus>();
    }
  } catch (exception) {
    print('Exception sending api : ' + exception.toString());
    return List<TourBus>();
  }
}
