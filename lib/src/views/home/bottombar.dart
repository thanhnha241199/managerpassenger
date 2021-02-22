import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:managepassengercar/src/views/history/history.dart';
import 'package:managepassengercar/src/views/home/homepage.dart';
import 'package:managepassengercar/src/views/notification/notification.dart';
import 'package:managepassengercar/src/views/payment/payment.dart';
import 'package:managepassengercar/src/views/profile/profile.dart';

class HomePage extends StatefulWidget {
  String user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Home(),
            History(),
            Payment(),
            Notifications(),
            Profile(user: widget.user)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        backgroundColor: Colors.white,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Trang chủ'),
            icon: Icon(Icons.home),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
              title: Text('Lịch sử'),
              icon: Icon(Icons.apps),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Pay'),
              icon: Icon(Icons.chat_bubble),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Thông báo'),
              icon: Icon(Icons.notifications),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Tài khoản'),
              icon: Icon(Icons.person),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
