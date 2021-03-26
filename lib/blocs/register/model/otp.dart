import 'dart:convert';

Otp otpFromJson(String str) => Otp.fromJson(json.decode(str));

String otpToJson(Otp data) => json.encode(data.toJson());

class Otp {
  Otp({
    this.otp,
  });

  int otp;

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
