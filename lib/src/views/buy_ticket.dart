import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  int selectRadio;
  DateTime selectedDate = DateTime.now();

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectRadio = 1;
  }
  setSelectedRadio(int val){
    setState(() {
      selectRadio = val;
    });
  }
  void _modalBottomSheetMenu(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0))),
              child: Container(
                margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      height: 5.0,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10.0),
                          child: selectRadio == "1"
                              ? Text(
                                  "Tuyến phổ biến",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "Khuyen mai",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  selected: selectRadio.compareTo(1) == 0 ? true : false,
                                  title: Text("Tuyen pho bien"),
                                  trailing: Radio(
                                    activeColor: Colors.red,
                                    value: 1,
                                    groupValue: selectRadio,
                                    onChanged: (value) {
                                      setSelectedRadio(value);
                                    },
                                  ),
                                ),
                                ListTile(
                                  selected: selectRadio.compareTo(0) == 0 ? true : false,
                                  title: Text("Khuyen mai"),
                                  trailing: Radio(
                                    activeColor: Colors.red,
                                    value: 0,
                                    groupValue: selectRadio,
                                    onChanged: (value) {
                                      setSelectedRadio(value);
                                    },
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date',
      cancelText: 'Not now',
      confirmText: 'Book',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool ontap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mua vé xe",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/orderbuy');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(EvaIcons.fileTextOutline),
                Text("Đơn mua"),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
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
              height: MediaQuery.of(context).size.height * 0.2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 95.0, left: 20.0, right: 20.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Điêm khởi hành",
                            style: TextStyle(),
                          ),
                          Text(
                            "Cần Thơ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(EvaIcons.syncOutline),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Điểm đến",
                            style: TextStyle(),
                          ),
                          Text(
                            "Vĩnh Long",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ngày khởi hành",
                              style: TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Khứ hồi",
                              style: TextStyle(fontSize: 18),
                            ),
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
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ontap
                        ? Column(
                            children: [
                              Text(
                                "Ngày về",
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      text: 'Tìm vé',
                      press: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tuyến phổ biến",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            _modalBottomSheetMenu(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Tuyến phổ biến",
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: ontap ? 400 : 370, right: 20, left: 20),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/schedules');
                              },
                              child: Icon(EvaIcons.arrowCircleRightOutline)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text("Ho Chi Minh"),
                              Spacer(),
                              Icon(EvaIcons.arrowForwardOutline),
                              Spacer(),
                              Text("Ninh Hoa")
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text("462.3 km"),
                              Spacer(),
                              Text(
                                "12 gio",
                              ),
                              Spacer(),
                              Text("Tu 225,000d")
                            ],
                          ),
                          trailing: Icon(EvaIcons.arrowCircleRightOutline),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
