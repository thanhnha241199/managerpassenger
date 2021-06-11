import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/utils/style.dart';
import 'package:managepassengercar/utils/app_style.dart';
import 'package:managepassengercar/utils/config.dart';

class ChedulesBus extends StatefulWidget {
  String id;
  ChedulesBus({this.id});
  @override
  _ChedulesBusState createState() => _ChedulesBusState();
}

class _ChedulesBusState extends State<ChedulesBus> {
  Map<String, dynamic> _schedule;
  bool _loading;
  String locationstart = "aaaa,", locationend = "aaaaa";

  Future<Schedule> getHttp() async {
    try {
      Response response = await Dio()
          .get('${ServerAddress.serveraddress}getschedule', queryParameters: {
        "idtour": widget.id,
      });
      if (response != null && response.statusCode == 200) {
        setState(() {
          _schedule = response.data;
          schedule = _schedule['schedule'];
          print(schedule);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> schedule;
  bool check;
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _loading = true;
    isLoading = true;
    getHttp().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            isLoading ? tr('loading') : tr('schedule'),
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.white,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('detailschedule'),
                          style: AppTextStyles.textSize20(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              _schedule['locationstart'],
                              style:
                                  AppTextStyles.textSize20(color: Colors.green),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              _schedule['locationend'],
                              style:
                                  AppTextStyles.textSize20(color: Colors.red),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(""),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(tr('time'),
                                    style: AppTextStyles.textSize18(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(tr('location'),
                                        style: AppTextStyles.textSize18(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black)),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: index == 0
                                  ? Icon(
                                      Icons.pin_drop_outlined,
                                      color: Colors.redAccent,
                                    )
                                  : index == schedule.length - 1
                                      ? Icon(
                                          Icons.radio_button_checked_outlined,
                                          color: Colors.green,
                                        )
                                      : Icon(Icons.pin_drop_rounded),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                schedule[index]['time'],
                                style: AppTextStyles.textSize14(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                title: Text(
                                  schedule[index]['location'],
                                  style: AppTextStyles.textSize16(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  schedule[index]['address'],
                                  style: AppTextStyles.textSize14(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: schedule.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: tr('license'),
                              style: AppTextStyles.textSize14(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)),
                          TextSpan(
                              text: '19006667',
                              style: AppTextStyles.textSize14(
                                  color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  )
                ])));
  }
}
