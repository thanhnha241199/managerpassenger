import 'package:flutter/material.dart';
import 'package:managepassengercar/src/views/chat/routes.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes(),
      initialRoute: Routes.initScreen(),
    );
  }
}