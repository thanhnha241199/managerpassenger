import 'dart:convert';

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister(
      {this.username,
      this.password,
      this.name,
      this.phone,
      this.type,
      this.active});

  String username;
  String password;
  String active;
  String name;
  String phone;
  String type;
  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        username: json["username"],
        password: json["password"],
        name: json["name"],
        phone: json["phone"],
        type: json["type"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "email": username,
        "password": password,
        "name": name,
        "phone": phone,
        "type": type,
        "active": active,
      };
}
