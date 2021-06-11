import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/blocs/ticket/view/bottomsheet_location.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_position.dart';
import 'package:managepassengercar/blocs/ticket/view/time_choose_ticket.dart';

import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/ticket/choose_address.dart';
import 'package:managepassengercar/src/views/ticket/choose_location.dart';
import 'package:managepassengercar/src/views/ticket/order_ticket.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';
import 'package:managepassengercar/utils/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseTicket extends StatefulWidget {
  List<Discount> discount;
  TourBus tourBus;
  String timestart;
  String timeback;
  String datestart;
  final UserRepository userRepository;
  String dateback;
  String seat;
  String title;
  String titleback;
  String locationstart;
  String locationback;
  String seatback;
  bool dumplex;

  ChooseTicket(
      {this.tourBus,
      this.dumplex,
      this.userRepository,
      this.datestart,
      this.dateback,
      this.discount});

  @override
  _ChooseTicketState createState() => _ChooseTicketState();
}

class _ChooseTicketState extends State<ChooseTicket> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool ontap = false;
  bool _switchValue = false;
  String name, phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfor();
    print(widget.dumplex);
  }

  Future<void> getInfor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
      phone = preferences.getString('phone');
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tourBus.shuttle);
    return widget.dumplex
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  tr('choosecar'),
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                elevation: 0.0,
                actionsIconTheme: IconThemeData(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.red,
                  tabs: [
                    Tab(
                      child: Text(
                        tr('chieudi'),
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        tr('chieuve'),
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: MediaQuery.of(context).size.height * 0.12,
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(width: 20),
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: (10.0),
                              child: Container(
                                color: Color(0xFFf5f6f7),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('timesstart'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        widget.timestart ?? " ",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<String>(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return FractionallySizedBox(
                                                heightFactor: 0.7,
                                                child: BottomSheetTime(
                                                  price: widget.tourBus.price,
                                                  switchValue: _switchValue,
                                                  valueChanged: (value) {
                                                    setState(() {
                                                      _switchValue = value;
                                                    });
                                                  },
                                                  id: widget.tourBus.id,
                                                ));
                                          }).then((value) {
                                        if (value != null) {
                                          setState(() {
                                            widget.timestart = value;
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('edit'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr(
                                          'chooseseat',
                                        ),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      widget.seat == null
                                          ? Text(" ")
                                          : Text(
                                              widget.seat.trim(),
                                              style: TextStyle(fontSize: 18),
                                            )
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChoosePosition(
                                                          id: widget.tourBus.id,
                                                          price: widget
                                                              .tourBus.price)))
                                          .then((value) {
                                        if (value != null) {
                                          setState(() {
                                            widget.seat = value;
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('edit'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                            widget.tourBus.shuttle.compareTo("true") == 0
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Lựa chon",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BottomSheetAddress(
                                                    switchValue: _switchValue,
                                                    valueChanged: (value) {
                                                      setState(() {
                                                        _switchValue = value;
                                                      });
                                                    },
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              _switchValue
                                                  ? Text(
                                                      "Chọn bến xe",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  : Text(
                                                      "Chọn địa chỉ đón bạn",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            !_switchValue
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tr('substart'),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              widget.locationstart ?? " ",
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<String>(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return FractionallySizedBox(
                                                      heightFactor: 0.8,
                                                      child:
                                                          BottomSheetLocation(
                                                        switchValue:
                                                            _switchValue,
                                                        valueChanged: (value) {
                                                          setState(() {
                                                            _switchValue =
                                                                value;
                                                          });
                                                        },
                                                        id: widget.tourBus.id,
                                                      ));
                                                }).then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.locationstart =
                                                      value.split(',')[0];
                                                  widget.title =
                                                      value.split(',')[1];
                                                });
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                tr('edit'),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.edit,
                                                color: Colors.redAccent,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Địa điểm đón bạn",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              widget.locationstart ?? " ",
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<String>(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return FractionallySizedBox(
                                                      heightFactor: 0.8,
                                                      child:
                                                          BottomSheetChooseAddress(
                                                        switchValue:
                                                            _switchValue,
                                                        valueChanged: (value) {
                                                          setState(() {
                                                            _switchValue =
                                                                value;
                                                          });
                                                        },
                                                      ));
                                                }).then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  widget.locationstart =
                                                      value.split(',')[0];
                                                  widget.title =
                                                      value.split(',')[1];
                                                });
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                tr('edit'),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.edit,
                                                color: Colors.redAccent,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr('name'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                hintText: tr('nametemp'),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: TextField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: tr('phonetemp'),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: TextField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                                hintText: tr('emaitemp'),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 20.0,
                                                )),
                                            style: Constants.regularDarkText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          phone,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: MediaQuery.of(context).size.height * 0.12,
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(width: 20),
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.tourBus.locationend}=> ${widget.tourBus.locationstart} ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "${widget.tourBus.locationend} => ${widget.tourBus.locationstart} ",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: (10.0),
                              child: Container(
                                color: Color(0xFFf5f6f7),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('timesstart'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        widget.timeback ?? " ",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<String>(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return FractionallySizedBox(
                                                heightFactor: 0.9,
                                                child: BottomSheetTime(
                                                  price: widget.tourBus.price,
                                                  switchValue: _switchValue,
                                                  valueChanged: (value) {
                                                    setState(() {
                                                      _switchValue = value;
                                                    });
                                                  },
                                                  id: widget.tourBus.id,
                                                ));
                                          }).then((value) {
                                        if (value != null) {
                                          setState(() {
                                            widget.timeback = value;
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('edit'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('chooseseat'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      widget.seatback == null
                                          ? Text(" ")
                                          : Text(
                                              widget.seatback.trim(),
                                              style: TextStyle(fontSize: 18),
                                            )
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChoosePosition(
                                                    id: widget.tourBus.id,
                                                    price: widget.tourBus.price,
                                                  ))).then((value) {
                                        setState(() {
                                          widget.seatback = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('edit'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('substart'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        widget.locationback ?? " ",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<String>(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return FractionallySizedBox(
                                                heightFactor: 0.8,
                                                child: BottomSheetLocation(
                                                  switchValue: _switchValue,
                                                  valueChanged: (value) {
                                                    setState(() {
                                                      _switchValue = value;
                                                    });
                                                  },
                                                  id: widget.tourBus.id,
                                                ));
                                          }).then((value) {
                                        setState(() {
                                          if (value != null) {
                                            setState(() {
                                              widget.locationback =
                                                  value.split(',')[0];
                                              widget.titleback =
                                                  value.split(',')[1];
                                            });
                                          }
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tr('edit'),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: DefaultButton(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderTicket(
                                  discount: widget.discount,
                                  tourBus: widget.tourBus,
                                  dumplex: true,
                                  time: widget.timestart,
                                  title: widget.title,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  address: widget.locationstart,
                                  dateback: widget.dateback,
                                  datestart: widget.datestart,
                                  seat: widget.seat,
                                )));
                  },
                  text: tr('continue'),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                tr('choosecar'),
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              brightness: Theme.of(context).brightness == Brightness.dark
                  ? Brightness.dark
                  : Brightness.light,
              elevation: 0.0,
              actionsIconTheme: IconThemeData(color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(width: 20),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (10.0),
                      child: Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Color(0xFFf5f6f7),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr('timesstart'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                widget.timestart ?? " ",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<String>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.7,
                                        child: BottomSheetTime(
                                          price: widget.tourBus.price,
                                          switchValue: _switchValue,
                                          valueChanged: (value) {
                                            setState(() {
                                              _switchValue = value;
                                            });
                                          },
                                          id: widget.tourBus.id,
                                        ));
                                  }).then((value) {
                                if (value != null) {
                                  setState(() {
                                    widget.timestart = value;
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  tr('edit'),
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr(
                                  'chooseseat',
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                              widget.seat == null
                                  ? Text(" ")
                                  : Text(
                                      widget.seat.trim(),
                                      style: TextStyle(fontSize: 18),
                                    )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChoosePosition(
                                              id: widget.tourBus.id,
                                              price: widget.tourBus.price)))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    widget.seat = value;
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  tr('edit'),
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                    widget.tourBus.shuttle == "true"
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('chooseoption'),
                                  style: TextStyle(fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BottomSheetAddress(
                                            switchValue: _switchValue,
                                            valueChanged: (value) {
                                              setState(() {
                                                _switchValue = value;
                                              });
                                            },
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      _switchValue
                                          ? Text(
                                              tr('choosecar'),
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text(
                                              tr('chooselocation'),
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    !_switchValue
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr('substart'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      widget.locationstart ?? " ",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<String>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                              heightFactor: 0.8,
                                              child: BottomSheetLocation(
                                                switchValue: _switchValue,
                                                valueChanged: (value) {
                                                  setState(() {
                                                    _switchValue = value;
                                                  });
                                                },
                                                id: widget.tourBus.id,
                                              ));
                                        }).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          widget.locationstart =
                                              value.split(',')[0];
                                          widget.title = value.split(',')[1];
                                        });
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        tr('edit'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Địa điểm đón bạn",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      widget.locationstart ?? " ",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<String>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                              heightFactor: 0.8,
                                              child: BottomSheetChooseAddress(
                                                switchValue: _switchValue,
                                                valueChanged: (value) {
                                                  setState(() {
                                                    _switchValue = value;
                                                  });
                                                },
                                              ));
                                        }).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          widget.locationstart =
                                              value.split(',')[0];
                                          widget.title = value.split(',')[1];
                                        });
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        tr('edit'),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Text(tr('orderhelp'),
                              style: AppTextStyles.textSize18(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)),
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('name'),
                                    style: AppTextStyles.textSize18(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Color(0xFFF2F2F2),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: TextField(
                                    controller: nameController,
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
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Color(0xFFF2F2F2),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: TextField(
                                    controller: phoneController,
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
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Color(0xFFF2F2F2),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: TextField(
                                    controller: emailController,
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
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: AppTextStyles.textSize18(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  phone,
                                  style: AppTextStyles.textSize18(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                vertical: (15),
                horizontal: (30),
              ),
              child: DefaultButton(
                press: () {
                  if (widget.seat == null ||
                      widget.timestart == null ||
                      widget.locationstart == null) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      headerAnimationLoop: true,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Thông báo',
                      desc:
                          'Bạn chưa chọn thời gian khởi hành hoặc chỗ ngồi hoặc điểm đón bán!',
                      buttonsTextStyle: TextStyle(color: Colors.black),
                    )..show();
                  } else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderTicket(
                                  tourBus: widget.tourBus,
                                  discount: widget.discount,
                                  userRepository: widget.userRepository,
                                  dumplex: false,
                                  time: widget.timestart,
                                  title: widget.title,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  dateback: widget.dateback,
                                  datestart: widget.datestart,
                                  address: widget.locationstart,
                                  seat: widget.seat,
                                )));
                },
                text: tr('continue'),
              ),
            ));
  }
}
