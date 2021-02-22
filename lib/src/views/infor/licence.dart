import 'package:flutter/material.dart';

class Licence extends StatefulWidget {
  @override
  _LicenceState createState() => _LicenceState();
}

class _LicenceState extends State<Licence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Cac dieu khoan quy dinh",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        )
    );
  }
}
