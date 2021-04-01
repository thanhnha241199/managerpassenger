import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/employee/bloc/employee_bloc.dart';
import 'package:managepassengercar/blocs/employee/view/changepass_employee.dart';
import 'package:managepassengercar/blocs/employee/view/checkIn.dart';
import 'package:managepassengercar/blocs/employee/view/check_in_work.dart';
import 'package:managepassengercar/blocs/employee/view/qr.dart';
import 'package:managepassengercar/blocs/employee/view/schedule.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/setting/view/setting.dart';
import 'package:managepassengercar/blocs/userprofile/view/profile_user.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/chat/chatuserscreen.dart';
import 'package:managepassengercar/src/views/chat/global.dart';
import 'package:managepassengercar/src/views/chat/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Employee extends StatefulWidget {
  final UserRepository userRepository;

  Employee({Key key, @required this.userRepository}) : super(key: key);
  @override
  _EmployeeState createState() => _EmployeeState();
}

final List<String> imgList = [
  'https://image.freepik.com/free-vector/public-city-transport-app-illustration-flat-cartoon-tiny-couple-people-using-smartphone-with-city-map-navigation-bus-ride_121223-643.jpg',
  'https://image.freepik.com/free-vector/online-car-service-app-illustration-flat-cartoon-tiny-couple-people-order-taxi-cab-using-smartphone-mobile-ordering-transport_121223-640.jpg',
  'https://st3.depositphotos.com/7282720/32196/v/950/depositphotos_321962056-stock-illustration-people-order-smart-phone-app.jpg'
];

class _EmployeeState extends State<Employee> {
  int _selectedDestination = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<EmployeeBloc>(context).add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(userRepository: widget.userRepository)),
              (route) => false);
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FailureState) {
            return Center(
              child: Text(state.msg),
            );
          }
          if (state is SuccessState) {
            G.initDummyUsers();
            UserChat userA = new UserChat(
                id: state.profileUser.id,
                name: state.profileUser.name,
                email: state.profileUser.email);
            G.loggedInUser = userA;
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  tr("home"),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                elevation: 0,
                actionsIconTheme: IconThemeData(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      onDetailsPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileUserScreen()));
                      },
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.cyan,
                        child: Text(
                            state.profileUser.name
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(fontSize: 24)),
                      ),
                      accountName: Text(
                        state.profileUser.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      accountEmail: Text(state.profileUser.email),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(tr('home')),
                      selected: _selectedDestination == 0,
                      onTap: () {
                        if (_selectedDestination != 0) {
                          selectDestination(0);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Employee(
                                        userRepository: widget.userRepository,
                                      )));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.timelapse),
                      title: Text(tr('ticket')),
                      selected: _selectedDestination == 1,
                      onTap: () {
                        selectDestination(1);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduleTour(
                                      userRepository: widget.userRepository,
                                      index: 1,
                                    )));
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text(tr('title_setting')),
                        selected: _selectedDestination == 3,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingApp()));
                          selectDestination(3);
                        }),
                    ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text(tr('changepass')),
                        selected: _selectedDestination == 4,
                        onTap: () async {
                          selectDestination(4);
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormChangePassword(
                                        email: pref.get("name"),
                                      )));
                        }),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(tr('logout')),
                      selected: _selectedDestination == 5,
                      onTap: () async {
                        selectDestination(5);
                        final action = CupertinoActionSheet(
                          message: Text(
                            tr('alertout'),
                            style: TextStyle(fontSize: 15.0),
                          ),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text(tr('logout')),
                              isDestructiveAction: true,
                              onPressed: () async {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoggedOut());
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove("token");
                                prefs.remove("name");
                                Navigator.pop(context);
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text(tr('cancel')),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                        showCupertinoModalPopup(
                            context: context, builder: (context) => action);
                      },
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        child: CarouselSlider(
                      options: CarouselOptions(
                        scrollPhysics: BouncingScrollPhysics(),
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                      items: imageSliders,
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanWorkScreen()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.adjust,
                                    size: 70,
                                  ),
                                  Text(tr('checkinwork')),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanScreen()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    size: 70,
                                  ),
                                  Text(tr('scanqr')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (pref.getString("token") == null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                            userRepository:
                                                widget.userRepository)));
                              } else {
                                // Navigator.push(
                                //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatUsersScreen()));
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 70,
                                  ),
                                  Text(tr('chat')),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 70,
                                  ),
                                  Text(tr('rating')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanScreen()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.toys,
                                    size: 70,
                                  ),
                                  Text("Scan QR Code"),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckIn()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.navigation,
                                    size: 70,
                                  ),
                                  Text("Check In"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home,
                                    size: 70,
                                  ),
                                  Text("AAA"),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 70,
                                ),
                                Text("AAA"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ),
            ),
          ))
      .toList();
}
