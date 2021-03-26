import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:managepassengercar/blocs/login/model/message.dart';
import 'package:managepassengercar/blocs/register/model/otp.dart';
import 'package:managepassengercar/blocs/register/model/user_register.dart';
import 'package:managepassengercar/src/models/api_model.dart';
import 'package:managepassengercar/src/views/chat/user.dart';

final _base = "https://managerpassenger.herokuapp.com";
final _tokenEndpoint = "/authenticate";
final _signup = "/confirm";
final _tokenURL = _base + _tokenEndpoint;
final _confirmURL = _base + _signup;
final _confirmforgetURL = _base + '/forgetpass';
final _signupURL = _base + '/adduser';
final _resetURL = _base + '/resetpassword';

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Otp> confirmOTP(UserRegister userRegister) async {
  print(_confirmURL);
  print(userRegisterToJson(userRegister));
  final http.Response response = await http.post(
    _confirmURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: userRegisterToJson(userRegister),
  );
  if (response.statusCode == 200) {
    return Otp.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Otp> confirmOTPForget(Map map) async {
  print(_confirmforgetURL);
  print(map);
  final http.Response response = await http.post(
    _confirmforgetURL,
    body: map,
  );
  if (response.statusCode == 200) {
    return Otp.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> signUp(UserRegister userRegister) async {
  print(_signupURL);
  print(userRegisterToJson(userRegister));
  final http.Response response = await http.post(
    _signupURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: userRegisterToJson(userRegister),
  );
  return response.body;
}

Future<Message> resetpassword(UserLogin userLogin) async {
  print(_resetURL);
  final http.Response response = await http.post(_resetURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userLogin.toDatabaseJson()));
  if (response.statusCode == 200) {
    return Message.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
