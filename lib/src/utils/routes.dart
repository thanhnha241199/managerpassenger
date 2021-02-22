import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/introduction/introdure_page.dart';
import 'package:managepassengercar/src/views/otp/otp_page.dart';
import 'package:managepassengercar/src/views/profile/user_profile.dart';
import 'package:managepassengercar/src/views/signin/forget_password.dart';
import 'package:managepassengercar/src/views/signin/signin.dart';
import 'package:managepassengercar/src/views/signup/signup.dart';
import 'package:managepassengercar/src/views/splash/splash_page.dart';
import 'package:managepassengercar/src/views/widget/homeappchat.dart';

Object appRoutes = {
  '/': (context) => HomePage(),
  '/splash': (context) => SplashScreenPage(),
  '/intro': (context) => IntrodurePage(),
  '/homeapp': (context) => HomeApp(),
  '/login': (context) => LoginPage(),
  '/userprofile': (context) => ProfilePage(),
  '/signup': (context) => RegisterPage(),
  '/otp': (context) => OTPPage(),
  '/forget': (context) => ForgetPass(),
};