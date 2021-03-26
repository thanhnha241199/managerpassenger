import 'dart:convert';

ProfileUser profileUserFromJson(String str) => ProfileUser.fromJson(json.decode(str));

String profileUserToJson(ProfileUser data) => json.encode(data.toJson());

class ProfileUser {
  ProfileUser({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.id,
  });

  String name;
  String email;
  String phone;
  String image;
  String id;

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "_id": id,
  };
}
