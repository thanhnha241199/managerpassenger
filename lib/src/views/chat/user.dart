import 'dart:convert';

UserChat userFromJson(String str) => UserChat.fromJson(json.decode(str));

String userToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  UserChat({this.id, this.email, this.name, this.image, this.type});

  String id;
  String email;
  String name;
  String image;
  String type;

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "image": image,
        "type": type,
      };
}
