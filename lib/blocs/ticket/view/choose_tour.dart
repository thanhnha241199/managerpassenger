import 'package:flutter/material.dart';

class ChooseTour extends StatelessWidget {
  final List tour;
  ChooseTour({this.tour});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Chọn tuyến',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
          itemCount: tour.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pop(context, tour[index]);
              },
              title: Text(tour[index]),
            );
          }),
    );
  }
}
