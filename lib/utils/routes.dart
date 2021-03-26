import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/repository/user_repository.dart';

const String LOGIN_PAGE = "/login";
const String SPLASH_PAGE = "/";
const String HOME_PAGE = "/home";
const String USER_DETAIL = "/user_detail";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final UserRepository userRepository = UserRepository();
    switch (settings.name) {
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginPage());
      // case HOME_PAGE:
      //   return MaterialPageRoute(builder: (_) => HomePage());
      // case SPLASH_PAGE:
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      // case SPLASH_PAGE:
      //   return MaterialPageRoute(builder: (_) => EditUserDetail());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}