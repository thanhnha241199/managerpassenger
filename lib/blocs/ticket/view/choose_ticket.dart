import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_position.dart';
import 'package:managepassengercar/blocs/ticket/view/time_choose_ticket.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/ticket/choose_location.dart';
import 'package:managepassengercar/src/views/ticket/order_ticket.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseTicket extends StatefulWidget {
  TourBus tourBus;
  String timestart;
  String timeback;
  String datestart;
  String dateback;
  String seat;
  String title;
  String titleback;
  String locationstart;
  String locationback;
  String seatback;
  bool dumplex;

  ChooseTicket({this.tourBus, this.dumplex, this.datestart, this.dateback});

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
    return widget.dumplex
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  tr('choosecar'),
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
                    Navigator.pop(context, true);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.red,
                  tabs: [
                    Tab(
                      child: Text(tr('chieudi')),
                    ),
                    Tab(
                      child: Text(tr('chieuve')),
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
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        Text(tr('edit'),
                                            style: TextStyle(fontSize: 18)),
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
                                                    price: widget.tourBus.price,
                                                  ))).then((value) {
                                        setState(() {
                                          widget.seat = value;
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
                                        widget.locationstart ?? " ",
                                        style: TextStyle(fontSize: 18),
                                      )
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
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                  tourBus: widget.tourBus,
                                  dumplex: ontap,
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
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                    widget.locationstart = value.split(',')[0];
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
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr('name'),
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
                                      color: Color(0xFFF2F2F2),
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
                                      color: Color(0xFFF2F2F2),
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
                                      color: Color(0xFFF2F2F2),
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
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            bottomNavigationBar: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: DefaultButton(
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderTicket(
                                tourBus: widget.tourBus,
                                dumplex: ontap,
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
            ),
          );
  }
}
