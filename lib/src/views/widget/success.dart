import 'dart:async';

import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  Widget page;
  String title;
  Success({this.page, this.title});
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 3000), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.page), (route) => false));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration:
                    BoxDecoration(color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 350,
                          child: Image.asset(
                            "assets/images/small_icon/success.png",
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Container(
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  color: Color(0xFF67778E),
                                  fontFamily:
                                  'Roboto-Light.ttf',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ]),
        )
    );
  }
}