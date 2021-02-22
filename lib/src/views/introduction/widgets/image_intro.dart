import 'package:flutter/material.dart';

class ImageIntro extends StatelessWidget {
  final String assetName;
  ImageIntro({this.assetName});
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Image.asset(
        'assets/images/onbroading/$assetName.png',
        width: 250.0,
        height: 250.0,
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}