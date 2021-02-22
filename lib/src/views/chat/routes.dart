import 'package:managepassengercar/src/views/chat/chatscreen.dart';
import 'package:managepassengercar/src/views/chat/chatuserscreen.dart';
import 'package:managepassengercar/src/views/chat/login.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.ROUTE_ID: (context) => LoginScreen(),
      ChatUsersScreen.ROUTE_ID: (context) => ChatUsersScreen(),
      ChatScreen.ROUTE_ID: (context) => ChatScreen(),
    };
  }

  static initScreen() {
    return LoginScreen.ROUTE_ID;
  }
}