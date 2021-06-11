import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:managepassengercar/blocs/rental/bloc/rental_bloc.dart';
import 'package:managepassengercar/blocs/rental/view/bottom_sheet.dart';
import 'package:managepassengercar/blocs/rental/view/bottom_sheet_seat.dart';
import 'package:managepassengercar/blocs/rental/view/bottom_sheet_type.dart';
import 'package:managepassengercar/blocs/savelocation/view/autocomplete.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/blocs/rental/view/order_rental.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/home/test.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RentalScreen extends StatefulWidget {
  @override
  _RentalScreenState createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  bool _switchValue = true;
  bool _switchValuetype = true;
  bool _switchValueseat = true;
  bool ontap = false;
  DateTime _date = DateTime.now();
  DateTime _dateend = DateTime.now();
  String locationstart, locationend;
  String id;
  TextEditingController quantyController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<void> getInfor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id');
    });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    getInfor();
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOs = IOSInitializationSettings();
    // var initSetttings = InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOs);

    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
  }

  // Future onSelectNotification(String payload) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return NewScreen(
  //       payload: payload,
  //     );
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          tr('rental'),
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
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print(id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderRental(
                            id: id,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(EvaIcons.fileTextOutline),
                Text(tr('rentalorder')),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () async {
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                ).then((value) {
                  setState(() {
                    locationstart = value.description;
                  });
                  return value;
                });
                print(result);
              },
              child: Container(
                child: ListTile(
                  leading: Column(
                    children: [
                      Icon(
                        Icons.fiber_manual_record_outlined,
                        color: Colors.green,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  title: Text(
                    tr('start'),
                    style: TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    locationstart ?? tr('substart'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                ).then((value) {
                  setState(() {
                    locationend = value.description;
                  });
                  return value;
                });
                print(result);
              },
              child: Container(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.orangeAccent,
                  ),
                  title: Text(
                    tr('end'),
                    style: TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    locationend ?? tr('subend'),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('option'),
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetRadio(
                                    switchValue: _switchValue,
                                    valueChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 1.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                _switchValue
                                    ? Text(
                                        tr('1chieu'),
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : Text(
                                        tr('2chieu'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                Spacer(),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('quanti'),
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width / 1.2,
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextField(
                            controller: quantyController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: tr('quanti'),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 20.0,
                                )),
                            style: Constants.regularDarkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('datestart'),
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        _date = date;
                      }, currentTime: DateTime.now());
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 1.2,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "$_date",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _switchValue
                ? Text("")
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr('dateend'),
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            }, onConfirm: (date) {
                              _dateend = date;
                            }, currentTime: DateTime.now());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 1.2,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "$_dateend",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('type'),
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetRadioType(
                                    switchValue: _switchValuetype,
                                    valueChanged: (value) {
                                      setState(() {
                                        _switchValuetype = value;
                                      });
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 1.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                _switchValuetype
                                    ? Text(
                                        tr('standard'),
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : Text(
                                        tr('vip'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                Spacer(),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("quanseat"),
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetRadioSeat(
                                    switchValue: _switchValueseat,
                                    valueChanged: (value) {
                                      setState(() {
                                        _switchValueseat = value;
                                      });
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 1.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                _switchValueseat
                                    ? Text(
                                        tr('4seat'),
                                        style: TextStyle(fontSize: 18),
                                      )
                                    : Text(
                                        tr('16seat'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                Spacer(),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('note'),
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      controller: noteController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: tr('note'),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 20.0,
                          )),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          tr('orderhelp'),
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SwitchControl(
                          onChanged: (value) {
                            if (ontap == true) {
                              setState(() {
                                ontap = false;
                              });
                            } else {
                              setState(() {
                                ontap = true;
                              });
                            }
                          },
                          value: ontap,
                        ),
                      ],
                    ),
                  ),
                  ontap
                      ? Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr('name'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 1.2,
                                margin: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: tr('nametemp'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 20.0,
                                      )),
                                  style: Constants.regularDarkText,
                                ),
                              ),
                              Text(
                                tr('phone'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 1.2,
                                margin: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: tr('phonetemp'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 20.0,
                                      )),
                                  style: Constants.regularDarkText,
                                ),
                              ),
                              Text(
                                tr('email'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 1.2,
                                margin: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: tr('emaitemp'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 20.0,
                                      )),
                                  style: Constants.regularDarkText,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text("")
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<RentalBloc, RentalState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Success(
                        title: "Order Successfull",
                        page: HomePage(
                            // userRepository: widget.userRepository,
                            ))),
                (route) => false);
            //  showNotification();
          }
          if (state is FailureState) {
            print("Order Failed");
          }
        },
        child: BlocBuilder<RentalBloc, RentalState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: state is LoadingState
                  ? CircularProgressIndicator()
                  : DefaultButton(
                      press: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        BlocProvider.of<RentalBloc>(context).add(
                            OrderRentalEvent(
                                uid: pref.getString('id'),
                                name: ontap == false
                                    ? pref.getString('name')
                                    : nameController.text,
                                phone: ontap == false
                                    ? pref.getString('phone')
                                    : phoneController.text,
                                email: ontap == false
                                    ? pref.getString('email')
                                    : emailController.text,
                                locationstart: locationstart,
                                locationend: locationend,
                                quanticus: quantyController.text,
                                note: noteController.text,
                                quantyseat: _switchValueseat ? "4" : "16",
                                timeend: _switchValue
                                    ? null
                                    : _dateend.toLocal().toString(),
                                timestart: _date.toLocal().toString(),
                                type: _switchValuetype
                                    ? "Tieu chuan"
                                    : "Hang sang"));
                      },
                      text: tr('request'),
                    ),
            );
          },
        ),
      ),
    );
  }

  // showNotification() async {
  //   var android = new AndroidNotificationDetails(
  //       'id', 'channel ', 'description',
  //       priority: Priority.High, importance: Importance.Max);
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android, iOS);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
  //       payload: 'Welcome to the Local Notification demo ');
  // }
}
