import 'dart:convert';

UserChat userFromJson(String str) => UserChat.fromJson(json.decode(str));

String userToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  UserChat({
    this.id,
    this.email,
    this.name,
    this.image,
  });

  String id;
  String email;
  String name;
  String image;

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "name": name,
    "image": image,
  };
}
