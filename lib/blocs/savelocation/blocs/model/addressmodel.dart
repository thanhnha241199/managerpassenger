// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.id,
    this.name,
    this.districts,
  });

  String id;
  String name;
  List<District> districts;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["Id"],
        name: json["Name"],
        districts: List<District>.from(
            json["Districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.name,
    this.wards,
  });

  String id;
  String name;
  List<Ward> wards;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["Id"],
        name: json["Name"],
        wards: List<Ward>.from(json["Wards"].map((x) => Ward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Wards": List<dynamic>.from(wards.map((x) => x.toJson())),
      };
}

class Ward {
  Ward({
    this.id,
    this.name,
    this.level,
  });

  String id;
  String name;
  Level level;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json["Id"],
        name: json["Name"],
        level: levelValues.map[json["Level"]],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Level": levelValues.reverse[level],
      };
}

enum Level { PHNG, X, TH_TRN }

final levelValues =
    EnumValues({"Phường": Level.PHNG, "Thị trấn": Level.TH_TRN, "Xã": Level.X});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
