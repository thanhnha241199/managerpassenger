import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/employee/bloc/employee_bloc.dart';

import 'package:managepassengercar/blocs/employee/view/employee.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/userprofile/view/profile_user.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/models/seat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ScheduleTour extends StatefulWidget {
  final UserRepository userRepository;
  final int index;

  ScheduleTour({Key key, @required this.userRepository, this.index})
      : super(key: key);
  @override
  _ScheduleTourState createState() => _ScheduleTourState();
}

class _ScheduleTourState extends State<ScheduleTour> {
  int _selectedDestination;
  bool check;
  final formatCurrency = new NumberFormat("#,##0", "vi_VN");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDestination = widget.index;
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Schedule",
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
                  child: Text("P", style: TextStyle(fontSize: 24)),
                ),
                accountName: Text(
                  'Drawer Header',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                accountEmail: Text("abc@gmail.com"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Home'),
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
                leading: Icon(Icons.delete),
                title: Text('Schedule'),
                selected: _selectedDestination == 1,
                onTap: () {
                  if (_selectedDestination != 1) {
                    selectDestination(1);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleTour(
                                  userRepository: widget.userRepository,
                                  index: 1,
                                )));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Ticket'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                },
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Seat'),
                selected: _selectedDestination == 3,
                onTap: () {
                  selectDestination(3);
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Setting'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Change password'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign out'),
                selected: _selectedDestination == 4,
                onTap: () async {
                  selectDestination(4);
                  final action = CupertinoActionSheet(
                    message: Text(
                      "Bạn có muốn đăng xuất ?",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    actions: <Widget>[
                      CupertinoActionSheetAction(
                        child: Text("Đăng xuất"),
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
                      child: Text("Cancel"),
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
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
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
              return Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.toubus.length,
                  itemBuilder: (context, index) {
                    List<PickUp> pick;
                    List<Schedule> schedule;
                    List<Seat> seat;
                    pick = state.pickup
                        .where((element) =>
                            element.tourid == state.toubus[index].id)
                        .toList();
                    schedule = state.schedule
                        .where((element) =>
                            element.idtour == state.toubus[index].id)
                        .toList();
                    seat = state.seat
                        .where((element) =>
                            element.idtour == state.toubus[index].id)
                        .toList();
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.toubus[index].locationstart} - ${state.toubus[index].locationend}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Time: ${state.toubus[index].time} - Range: ${state.toubus[index].range} -  Price: ${formatCurrency.format(int.parse(state.toubus[index].price))}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                          ExpansionTile(
                            title: Text("Time"),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 5,
                                  childAspectRatio: 3 / 2,
                                  shrinkWrap: true,
                                  children: List.generate(
                                      pick[0].time.length,
                                      (i) => Chip(
                                          label: Text("${pick[0].time[i]}")))),
                            ],
                          ),
                          ExpansionTile(
                            title: Text("Schedule"),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: GridView.count(
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 1,
                                    childAspectRatio: 10 / 1,
                                    shrinkWrap: true,
                                    children: List.generate(
                                        schedule[0].schedule.length,
                                        (i) => Text(
                                            "${schedule[0].schedule[i].time} - ${schedule[0].schedule[i].address}"))),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: Text("Seat"),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                title: Text("Floors1"),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 5,
                                        childAspectRatio: 2 / 1,
                                        mainAxisSpacing: 8,
                                        shrinkWrap: true,
                                        children: List.generate(
                                            seat[0].floors1.length,
                                            (i) => ChoiceChip(
                                                  selected:
                                                      seat[0].floors1[i] ==
                                                              "trong"
                                                          ? true
                                                          : false,
                                                  onSelected: (value) {
                                                    if (seat[0].floors1[i] ==
                                                        "trong") {
                                                      setState(() {
                                                        seat[0].floors1[i] =
                                                            "checked";
                                                      });
                                                    } else {
                                                      setState(() {
                                                        seat[0].floors1[i] =
                                                            "trong";
                                                      });
                                                    }
                                                  },
                                                  label: Text(
                                                      ("A${i + 1}").toString()),
                                                ))),
                                  )
                                ],
                              ),
                              ExpansionTile(
                                title: Text("Floors2"),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 5,
                                        childAspectRatio: 2 / 1,
                                        mainAxisSpacing: 8,
                                        shrinkWrap: true,
                                        children: List.generate(
                                            seat[0].floors2.length,
                                            (i) => ChoiceChip(
                                                  selected:
                                                      seat[0].floors2[i] ==
                                                              "trong"
                                                          ? true
                                                          : false,
                                                  onSelected: (value) {
                                                    if (seat[0].floors2[i] ==
                                                        "trong") {
                                                      setState(() {
                                                        seat[0].floors2[i] =
                                                            "checked";
                                                      });
                                                    } else {
                                                      setState(() {
                                                        seat[0].floors2[i] =
                                                            "trong";
                                                      });
                                                    }
                                                  },
                                                  label: Text(
                                                      ("B${i + 1}").toString()),
                                                ))),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
