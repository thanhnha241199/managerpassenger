import 'package:flutter/material.dart';

class ChooseTour extends StatefulWidget {
  Set choose;
  ChooseTour({this.choose});
  @override
  _ChooseTourState createState() => _ChooseTourState();
}

class _ChooseTourState extends State<ChooseTour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chon tour",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: widget.choose.map((e) {
          return ListTile(
            onTap: () {
              Navigator.pop(context, e.toString());
            },
            title: Text(e),
          );
        }).toList(),
      ),
    );
  }
}
