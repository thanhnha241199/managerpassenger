import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/simple_bloc_observer.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userRepository = UserRepository();
  Bloc.observer = SimpleBlocObserver();
  runApp(EasyLocalization(
    child: MyApp(userRepository: userRepository),
    saveLocale: true,
    startLocale: Locale('en', 'US'),
    supportedLocales: [
      Locale('en', 'US'),
      Locale('vi', 'VN'),
    ],
    path: 'assets/langs',
  ));
}
