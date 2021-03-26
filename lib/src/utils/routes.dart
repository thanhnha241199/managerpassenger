import 'package:managepassengercar/src/views/banned/banned_driver.dart';
import 'package:managepassengercar/src/views/changepassword.dart';
import 'package:managepassengercar/src/views/history/order_buy.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/infor/licence.dart';
import 'package:managepassengercar/src/views/introduction/introdure_page.dart';
import 'package:managepassengercar/src/views/otp/otp_page.dart';
import 'file:///D:/Flutter/managepassengercar/lib/blocs/savelocation/view/form_location.dart';
import 'file:///D:/Flutter/managepassengercar/lib/blocs/register/view/forget_password/forget_form.dart';
import 'package:managepassengercar/src/views/signin/signin.dart';
import 'package:managepassengercar/src/views/signup/signup.dart';
import 'package:managepassengercar/src/views/splash/splash_page.dart';
import 'package:managepassengercar/src/views/test.dart';
import 'package:managepassengercar/src/views/ticket/chedules.dart';

Object appRoutes = {
  // '/': (context) => HomePage(),
  // '/splash': (context) => SplashScreenPage(userRepository: userRepository),
  '/intro': (context) => IntrodurePage(),
  // '/login': (context) => LoginPage(),
  '/signup': (context) => RegisterPage(),
  '/otp': (context) => OTPPage(),
  '/forget': (context) => ForgetPass(),
  '/changepass': (context) => FormChangePassword(),
  // '/location': (context) => SaveLocation(),
  '/addlocation': (context) => FormLocation(),
  '/banned': (context) => BannedDriver(),
  '/licence': (context) => Licence(),
  '/schedules': (context) => ChedulesBus(),
  '/orderbuy': (context) => OrderBuy(),
  '/test': (context) => MyLocation(),
};
