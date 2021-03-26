import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/history/history.dart';
import 'package:managepassengercar/src/views/home/homepage.dart';
import 'package:managepassengercar/src/views/notification/notification.dart';
import 'package:managepassengercar/src/views/payment/payment.dart';
import 'package:managepassengercar/src/views/profile/profile.dart';

class HomePage extends StatefulWidget {
  final UserRepository userRepository;

  HomePage({Key key, @required this.userRepository}) : super(key: key);

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
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: <Widget>[
            Home(userRepository: widget.userRepository),
            History(),
            Payment(),
            Notifications(),
            Profile(userRepository: widget.userRepository)
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
            title: Text(tr("home")),
            icon: Icon(Icons.home),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
              title: Text(tr("history")),
              icon: Icon(Icons.refresh),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text(tr("pay")),
              icon: Icon(Icons.payment_outlined),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text(tr("notification")),
              icon: Icon(Icons.notifications),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text(tr("account")),
              icon: Icon(Icons.person),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
