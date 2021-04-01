import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/savelocation/view/save_location.dart';
import 'package:managepassengercar/blocs/setting/view/setting.dart';
import 'package:managepassengercar/blocs/userprofile/view/profile_user.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/banned/banned_driver.dart';
import 'package:managepassengercar/src/views/changepassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final UserRepository userRepository;

  Profile({Key key, @required this.userRepository}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red[900], Colors.blue[700]])),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    tr("title_acc"),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                          userRepository:
                                              widget.userRepository)));
                            },
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              title: Text(
                                tr("welcome"),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                tr("signin/signup"),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileUserScreen()));
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
                    SizedBox(
                      height: (10.0),
                      child: Container(
                        color: Color(0xFFf5f6f7),
                      ),
                    ),
                    Container(
                        height: 60,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                title: Text(tr("setting")),
                                leading: Icon(
                                  EvaIcons.settingsOutline,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingApp()));
                              }),
                          Divider(),
                        ])),
                    Container(
                        height: 60,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                title: Text(tr("banner drive")),
                                leading: Icon(
                                  EvaIcons.loaderOutline,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BannedDriver()));
                              }),
                          Divider(),
                        ])),
                    Container(
                        height: 60,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                title: Text(tr("address")),
                                leading: Icon(
                                  EvaIcons.toggleRightOutline,
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SaveLocation()));
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
                                    title: Text(tr("changepass")),
                                    leading: Icon(
                                      EvaIcons.toggleLeftOutline,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FormChangePassword()));
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
                                    title: Text(tr("logout")),
                                    leading: Icon(
                                      EvaIcons.logOut,
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
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
                                      cancelButton: CupertinoActionSheetAction(
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
                            ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('name');
    setState(() {
      check = status;
    });
  }

  void logout() async {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("name");
    checkUser();
    Navigator.pop(context);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Logout Successfull!!"),
      ),
    );
  }
}
