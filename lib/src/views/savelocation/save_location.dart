import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';

class SaveLocation extends StatefulWidget {
  @override
  _SaveLocationState createState() => _SaveLocationState();
}

class _SaveLocationState extends State<SaveLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Địa điểm đã lưu",
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
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/addlocation");
            },
            icon: Icon(EvaIcons.arrowheadDown),
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location favorite"),
            Container(
              color: Colors.red,
              child: ListTile(
                title: Text("Home"),
                subtitle: Text("45/6 hem 6 mau thanh, XK- NK- TPCT"),
                leading: Icon(
                    EvaIcons.homeOutline
                ),
                trailing: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/addlocation");
                    print("AAA");
                  },
                  child: Column(
                    children: [
                      Icon(EvaIcons.edit2Outline),
                      Text("Edit")
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.red,
              child: ListTile(
                title: Text("Office"),
               // subtitle: Text("45/6 hem 6 mau thanh, XK- NK- TPCT"),
                leading: Icon(
                    EvaIcons.homeOutline
                ),
                trailing: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/addlocation");
                  },
                  child: Column(
                    children: [
                      Icon(EvaIcons.edit2Outline, ),
                      Text("Edit")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
