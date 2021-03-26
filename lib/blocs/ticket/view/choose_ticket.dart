import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_position.dart';
import 'package:managepassengercar/blocs/ticket/view/time_choose_ticket.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/src/views/ticket/choose_location.dart';
import 'package:managepassengercar/src/views/ticket/order_ticket.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';

class ChooseTicket extends StatefulWidget {
  TourBus tourBus;
  String timestart;
  String timeback;
  String seat;
  String locationstart;
  String locationback;
  String seatback;
  bool dumplex;

  ChooseTicket({this.tourBus, this.dumplex});

  @override
  _ChooseTicketState createState() => _ChooseTicketState();
}

class _ChooseTicketState extends State<ChooseTicket> {
  bool ontap = false;
  bool _switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.dumplex
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text(
                    "Chọn bến xe",
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
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  bottom: TabBar(
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(
                        child: Text("Chieu di"),
                      ),
                      Tab(
                        child: Text("Chieu ve"),
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: MediaQuery.of(context).size.height * 0.11,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}"),
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
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                      Text("Thoi gian khoi hanh"),
                                      Text(widget.timestart ?? " ")
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
                                                    id: widget.tourBus.id));
                                          }).then((value) {
                                        setState(() {
                                          widget.timestart = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                              height: MediaQuery.of(context).size.height * 0.1,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Chon so ghe"),
                                      widget.seat == null
                                          ? Text(" ")
                                          : Text(widget.seat.trim())
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
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                                      Text("Don ban tai dia diem"),
                                      Text(widget.locationstart ?? " ")
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      print(widget.tourBus.id);
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
                                          widget.locationstart = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                                  Text("Ban co muon mua ve cho nguoi khac"),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ho va ten"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "Ho va ten"),
                                        ),
                                        Text("So dien thoai"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "SDT"),
                                        ),
                                        Text("Email"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "Email"),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tran Van A"),
                                        Text("1234567899")
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: DefaultButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderTicket()));
                                },
                                text: "Tiep tuc",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: MediaQuery.of(context).size.height * 0.11,
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
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            "${widget.tourBus.locationend} => ${widget.tourBus.locationstart} "),
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
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                      Text("Thoi gian khoi hanh"),
                                      Text(widget.timeback ?? " ")
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
                                                  switchValue: _switchValue,
                                                  valueChanged: (value) {
                                                    setState(() {
                                                      _switchValue = value;
                                                    });
                                                  },
                                                  id: widget.tourBus.id,
                                                ));
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                              height: MediaQuery.of(context).size.height * 0.1,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Chon so ghe"),
                                      widget.seat == null
                                          ? Text(" ")
                                          : Text(widget.seatback.trim())
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChoosePosition()))
                                          .then((value) {
                                        setState(() {
                                          widget.seatback = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                                      Text("Don ban tai dia diem"),
                                      Text(widget.locationback ?? " ")
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
                                          widget.locationback = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Sua"),
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
                                  Text("Ban co muon mua ve cho nguoi khac"),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ho va ten"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "Ho va ten"),
                                        ),
                                        Text("So dien thoai"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "SDT"),
                                        ),
                                        Text("Email"),
                                        TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: BorderSide(),
                                              ),
                                              hintText: "Email"),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tran Van A"),
                                        Text("1234567899")
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: DefaultButton(
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderTicket()));
                                },
                                text: "Tiep tuc",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Chọn bến xe",
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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                              children: [
                                Text(
                                  "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}"),
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
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Thoi gian khoi hanh"),
                              Text(widget.timestart ?? " ")
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
                                    widget.timestart = value;
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text("Sua"),
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
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Chon so ghe"),
                              widget.seat == null
                                  ? Text(" ")
                                  : Text(widget.seat.trim())
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
                                Text("Sua"),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Don ban tai dia diem"),
                              Text(widget.locationstart ?? " ")
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
                                    widget.locationstart = value;
                                  });
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text("Sua"),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Text("Ban co muon mua ve cho nguoi khac"),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ho va ten"),
                                TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(),
                                      ),
                                      hintText: "Ho va ten"),
                                ),
                                Text("So dien thoai"),
                                TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(),
                                      ),
                                      hintText: "SDT"),
                                ),
                                Text("Email"),
                                TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        borderSide: BorderSide(),
                                      ),
                                      hintText: "Email"),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tran Van A"),
                                Text("1234567899")
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: DefaultButton(
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderTicket()));
                        },
                        text: "Tiep tuc",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
