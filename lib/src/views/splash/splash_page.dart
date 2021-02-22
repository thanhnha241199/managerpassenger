import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/introduction/introdure_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with AfterLayoutMixin<SplashScreenPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushNamedAndRemoveUntil(context, "/intro", (route) => false);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Timer(Duration(milliseconds: 3000), () => checkFirstSeen());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Container(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.4, 0.7, 0.9],
                  colors: [
                    Color(0xFFFAFAFA),
                    Color(0xFFF5F5F5),
                    Color(0xFFE0E0E0),
                    Color(0xFFD6D6D6),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(25)),
                          child: Icon(
                            Icons.directions_car_sharp,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "PassengerCar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
