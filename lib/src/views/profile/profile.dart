import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:managepassengercar/utils/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final UserRepository userRepository;

  Profile({Key key, @required this.userRepository}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var check, checktoken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue[400], Colors.blue[900]])),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    tr("title_acc"),
                    style: AppTextStyles.textSize20(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 110.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white),
                padding: EdgeInsets.symmetric(vertical: 10.0),
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
                    Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                title: Text(tr("setting")),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.9),
                                  child: Icon(
                                    EvaIcons.settingsOutline,
                                  ),
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
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.9),
                                child: Icon(
                                  EvaIcons.alertTriangleOutline,
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (pref.getString("token") == null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.QUESTION,
                                  headerAnimationLoop: true,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Bạn chưa đăng nhập',
                                  desc:
                                      'Vui lòng đăng nhập để có thể tiếp tục sử dung!',
                                  buttonsTextStyle:
                                      TextStyle(color: Colors.black),
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage(
                                                userRepository:
                                                    widget.userRepository)));
                                  },
                                )..show();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BannedDriver()));
                              }
                            },
                          ),
                          Divider(),
                        ])),
                    Container(
                        height: 60,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              title: Text(tr("address")),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.9),
                                child: Icon(
                                  EvaIcons.bookOpenOutline,
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (pref.getString("token") == null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.QUESTION,
                                  headerAnimationLoop: true,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Bạn chưa đăng nhập',
                                  desc:
                                      'Vui lòng đăng nhập để có thể tiếp tục sử dung!',
                                  buttonsTextStyle:
                                      TextStyle(color: Colors.black),
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage(
                                                userRepository:
                                                    widget.userRepository)));
                                  },
                                )..show();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SaveLocation()));
                              }
                            },
                          ),
                          Divider(),
                        ])),
                    Container(
                        height: 60,
                        child: Stack(children: <Widget>[
                          GestureDetector(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              title: Text(tr("changepass")),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.9),
                                child: Icon(
                                  EvaIcons.toggleLeftOutline,
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (pref.getString("token") == null) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.QUESTION,
                                  headerAnimationLoop: true,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Bạn chưa đăng nhập',
                                  desc:
                                      'Vui lòng đăng nhập để có thể tiếp tục sử dung!',
                                  buttonsTextStyle:
                                      TextStyle(color: Colors.black),
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage(
                                                userRepository:
                                                    widget.userRepository)));
                                  },
                                )..show();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormChangePassword(
                                              userRepository:
                                                  widget.userRepository,
                                            )));
                              }
                            },
                          ),
                          Divider()
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
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.9),
                                      child: Icon(
                                        EvaIcons.logOut,
                                      ),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                  onTap: () {
                                    final action = CupertinoActionSheet(
                                      message: Text(
                                        "Bạn có muốn đăng xuất ?",
                                        style: AppTextStyles.textSize16(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                      ),
                                      actions: <Widget>[
                                        CupertinoActionSheetAction(
                                          child: Text(
                                            "Đăng xuất",
                                            style: AppTextStyles.textSize16(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            logout();
                                          },
                                        )
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("Cancel");
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black12
                                      : Color(0xFFf5f6f7),
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
    var token = prefs.getString('token');
    setState(() {
      checktoken = token;
      check = status;
      print(checktoken);
    });
  }

  void logout() async {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("name");
    prefs.remove("id");
    prefs.remove("email");
    checkUser();
    Navigator.of(context, rootNavigator: true).pop("Cancel");
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Logout Successfull!!"),
      ),
    );
  }
}
