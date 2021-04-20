import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/setting/view/choose_language.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingApp extends StatefulWidget {
  @override
  _SettingAppState createState() => _SettingAppState();
}

class _SettingAppState extends State<SettingApp> {
  bool ontap = false;
  String language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckLanguage();
  }

  Future<String> CheckLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      language = pref.getString("language") ?? "English";
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseLanguage(
                  language: language,
                )),
      );
      setState(() {
        language = result ?? language;
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            tr("title_setting"),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        tr(
                          "manual",
                        ),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      child: Row(
                        children: [
                          Text(
                            tr("dartmode"),
                            style: TextStyle(
                              fontSize: 18,
                            ),
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
                              //   context.read<ThemeCubit>().toggleTheme();
                            },
                            value: ontap,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("setting lang"),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateAndDisplaySelection(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        child: Row(
                          children: [
                            Text(
                              tr("language"),
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            Text(
                              language,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
