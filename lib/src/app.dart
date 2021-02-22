import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managepassengercar/src/utils/routes.dart';
import 'package:managepassengercar/src/views/widget/UnknowPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Manage Passenger Car App',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.oswald(textStyle: textTheme.caption),
        ),
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: appRoutes,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => UnknownPage(),
        );
      },
    );
  }
}



