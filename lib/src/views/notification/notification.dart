import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Thông báo",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red[900], Colors.blue[700]])),
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/small_icon/notification.png",
                      height: 150.0,
                      width: 150.0,
                    ),
                    Text("Hiện tại, bạn không có thông báo mới nào."),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
