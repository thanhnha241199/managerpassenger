import 'dart:convert';

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister({this.username, this.password, this.name, this.phone});

  String username;
  String password;
  String name;
  String phone;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        username: json["username"],
        password: json["password"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": username,
        "password": password,
        "name": name,
        "phone": phone,
      };
}
