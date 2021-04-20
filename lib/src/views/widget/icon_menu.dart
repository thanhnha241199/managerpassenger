import 'package:flutter/material.dart';

Route _createRoute(Widget route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.bounceInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget IconMenu(Color color, String icon, String title, Widget navigation,
    BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
          onTap: () {
            Navigator.push(context, _createRoute(navigation));
          },
          child: Container(
              height: 70.0,
              width: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(100)),
              child: Image.asset(icon))),
      Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 8.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
            overflow: TextOverflow.ellipsis),
      )
    ],
  );
}
