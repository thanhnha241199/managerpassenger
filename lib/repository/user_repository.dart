import 'dart:async';

import 'package:managepassengercar/blocs/login/model/message.dart';
import 'package:managepassengercar/blocs/register/model/otp.dart';
import 'package:managepassengercar/blocs/register/model/user_register.dart';
import 'package:managepassengercar/modules/database/dao/user_dao.dart';
import 'package:managepassengercar/providers/api.dart';
import 'package:managepassengercar/src/models/api_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token.token);
    prefs.setString("email", username);
    prefs.setString("id", token.id);
    prefs.setString("name", token.name);
    prefs.setString("phone", token.phone);
    User user =
        User(id: 0, username: username, token: token.token, type: token.type);
    return user;
  }

  Future<Otp> confirmUser({
    @required String username,
    @required String password,
    @required String name,
    @required String phone,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserRegister userRegister = UserRegister(
        username: username,
        password: password,
        name: name,
        phone: phone,
        active: "true",
        type: "1");
    print("userregister : ${userRegister}");
    Otp otp = await confirmOTP(userRegister);
    prefs.setString('otp', otp.otp.toString());
    prefs.setString('email', username);
    prefs.setString('password', password);
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    return otp;
  }

  Future<Otp> confirmForget({
    @required String username,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map map = {"email": username};
    Otp otp = await confirmOTPForget(map);
    prefs.setString('otp', otp.otp.toString());
    prefs.setString('email', username);
    return otp;
  }

  Future<Message> resetPassword({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Message res = await resetpassword(userLogin);
    return res;
  }

  Future<String> createUser({
    @required String username,
    @required String password,
    @required String name,
    @required String phone,
  }) async {
    UserRegister userRegister = UserRegister(
        username: username,
        password: password,
        name: name,
        phone: phone,
        type: '1',
        active: "true");
    var res = await signUp(userRegister);
    print(res);
  }

  Future<void> persistToken({@required User user}) async {
    await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> deleteData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("email");
    pref.remove("name");
    pref.remove("phone");
    return true;
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  Future<bool> checkType() async {
    bool result = await userDao.checkType("1");
    return result;
  }
}
