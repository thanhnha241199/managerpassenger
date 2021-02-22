import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: CustomAlertDialog(
            title: "Logout",
            message: "Are you sure, do you want to logout?",
            onPostivePressed: () {
              continueCallBack();
            },
            positiveBtnText: 'Yes',
            negativeBtnText: 'No'));
  }
}

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        negativeBtnText != null
            ? FlatButton(
                child: Text(negativeBtnText),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                },
              )
            : null,
        positiveBtnText != null
            ? FlatButton(
                child: Text(positiveBtnText),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  if (onPostivePressed != null) {
                    onPostivePressed();
                  }
                },
              )
            : null,
      ],
    );
  }
}
