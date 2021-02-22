import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget IconMenu(Color color, IconData icon, String title){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 70.0,
        width: 70.0,
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100)
        ),
        child: IconButton(
          icon: Icon(icon),
          iconSize: 45,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 8.0),
        child: Text(title,
            overflow: TextOverflow.ellipsis),
      )
    ],
  );
}

