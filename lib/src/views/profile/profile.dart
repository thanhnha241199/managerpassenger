import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String user;

  Profile({this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var check;

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('token');
    setState(() {
      check = status;
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    checkUser();
    Navigator.pop(context);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Logout Successfull!!"),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Tài Khoản",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: Column(
                  children: [
                    check == null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/login");
                            },
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              title: Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Login/Register",
                                style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/userprofile");
                            },
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              title: Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${check}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          ),
                    Column(
                      children: [
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Quan ly don hang"),
                                    leading: Icon(
                                      EvaIcons.archiveOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ManageOrder()));
                                  }),
                              SizedBox(
                                height: (10.0),
                                child: Container(
                                  color: Color(0xFFf5f6f7),
                                ),
                              ),
                              //replyNotification(),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Don the nap"),
                                    leading: Icon(
                                      EvaIcons.browserOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {}),
                              Divider(),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Mua lan nua"),
                                    leading: Icon(
                                      EvaIcons.flip2Outline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {}),
                              SizedBox(
                                height: 10.0,
                                child: Container(
                                  color: Color(0xFFf5f6f7),
                                ),
                              ),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Da thich"),
                                    leading: Icon(
                                      EvaIcons.heartOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {}),
                              Divider(),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Banned Driver"),
                                    leading: Icon(
                                      EvaIcons.loaderOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, "/banned");
                                  }),
                              Divider(),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Save location"),
                                    leading: Icon(
                                      EvaIcons.toggleRightOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, "/location");
                                  }),
                              Divider(),
                            ])),
                        Container(
                            height: 60,
                            child: Stack(children: <Widget>[
                              GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8),
                                    title: Text("Change password"),
                                    leading: Icon(
                                      EvaIcons.toggleLeftOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, "/changepass");
                                  }),
                              Divider(),
                            ])),
                        check == null
                            ? Text("")
                            : Container(
                                height: 60,
                                child: Stack(children: <Widget>[
                                  GestureDetector(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(8),
                                        title: Text("Logout"),
                                        leading: Icon(
                                          EvaIcons.logOut,
                                        ),
                                        trailing:
                                            Icon(Icons.keyboard_arrow_right),
                                      ),
                                      onTap: () {
                                        final action = CupertinoActionSheet(
                                          message: Text(
                                            "Bạn có muốn đăng xuất ?",
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          actions: <Widget>[
                                            CupertinoActionSheetAction(
                                              child: Text("Đăng xuất"),
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                logout();
                                              },
                                            )
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) => action);
                                      }),
                                  SizedBox(
                                    height: (10.0),
                                    child: Container(
                                      color: Color(0xFFf5f6f7),
                                    ),
                                  ),
                                ])),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
