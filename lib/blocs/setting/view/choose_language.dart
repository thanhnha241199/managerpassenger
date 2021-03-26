import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatefulWidget {
  final String language;

  ChooseLanguage({this.language});

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          tr("choose"),
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
            Navigator.pop(context, widget.language);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(tr("language1")),
            onTap: () async {
              EasyLocalization.of(context).locale = Locale('vi', "VN");
              Navigator.pop(context, "Tiếng Việt");
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString("language", "Tiếng Việt");
            },
            trailing: widget.language == tr("language1")
                ? Icon(Icons.check)
                : Text(""),
          ),
          ListTile(
            title: Text(tr("language2")),
            onTap: () async {
              EasyLocalization.of(context).locale = Locale('en', "US");
              Navigator.pop(context, "English");
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString("language", "English");
            },
            trailing: widget.language == tr("language2")
                ? Icon(Icons.check)
                : Text(""),
          )
        ],
      ),
    );
  }
}
