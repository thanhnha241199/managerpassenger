import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:managepassengercar/blocs/userprofile/blocs/profile_bloc.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserScreen extends StatefulWidget {
  @override
  _ProfileUserScreenState createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ProfileUserScreen profileUser = new ProfileUserScreen();
  bool _status = true;
  var check;

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('token');
    setState(() {
      check = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    BlocProvider.of<ProfileBloc>(context).add(DoFetchEvent(token: check));
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            tr("detail profile"),
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
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingProfileState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FailureProfileState) {
              return Scaffold(
                body: Center(
                  child: Text(state.msg),
                ),
              );
            }
            if (state is SuccessProfileState) {
              nameController.text = state.profile.name;
              emailController.text = state.profile.email;
              idController.text = state.profile.id.substring(0, 20) + "...";
              phoneController.text = state.profile.phone;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Stack(fit: StackFit.loose, children: <
                                    Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      state.profile.image != ""
                                          ? GestureDetector(
                                              onTap: () {
                                                _showPicker(context);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 45,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(45)),
                                                  child: Container(
                                                    width: 340.0,
                                                    height: 340.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'assets/images/small_icon/loading.gif',
                                                      image:
                                                          state.profile.image,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          : GestureDetector(
                                              onTap: () {
                                                _showPicker(context);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 45,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(45)),
                                                  child: Container(
                                                    width: 340.0,
                                                    height: 340.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'assets/images/small_icon/loading.gif',
                                                      image:
                                                          "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              tr("persion info"),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditIcon()
                                                : new Container(),
                                          ],
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              tr("name"),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: 25.0, top: 2.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              12,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: new TextField(
                                        controller: nameController,
                                        enabled: !_status,
                                        autofocus: !_status,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                              vertical: 20.0,
                                            )),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 10.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              tr("email"),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: 25.0, top: 2.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              12,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: new TextField(
                                        controller: emailController,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                              vertical: 20.0,
                                            )),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              tr("UID"),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: 25.0, top: 2.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              12,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: new TextField(
                                        controller: idController,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                              vertical: 20.0,
                                            )),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    child: Container(
                                      child: new Text(
                                        tr("phone"),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 25.0, top: 2.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 12,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 24.0,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: new TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,
                                      enabled: !_status,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 20.0,
                                          )),
                                    ),
                                  ),
                                ),
                                !_status
                                    ? _getActionButtons(
                                        context, state.profile.image)
                                    : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  File _imageFile;
  final picker = ImagePicker();

  Future pickCamera(BuildContext context) async {
    final pickedCamera = await picker.getImage(source: ImageSource.camera);

    _imageFile = File(pickedCamera.path);
    Navigator.pop(context);
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    SharedPreferences pref = await SharedPreferences.getInstance();
    taskSnapshot.ref.getDownloadURL().then((value) {
      print(value);

      BlocProvider.of<ProfileBloc>(context).add(UpdateEvent(
          id: pref.getString("id"),
          token: pref.getString("token"),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          image: value));
    }).whenComplete(() => Navigator.pop(context));
  }

  Future pickLibrary(BuildContext context) async {
    final pickeeLibrary = await picker.getImage(source: ImageSource.gallery);

    _imageFile = File(pickeeLibrary.path);
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    SharedPreferences pref = await SharedPreferences.getInstance();
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {
      print(value);
      BlocProvider.of<ProfileBloc>(context).add(UpdateEvent(
          id: pref.getString("id"),
          token: pref.getString("token"),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          image: value));
    }).whenComplete(() => Navigator.pop(context));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Container(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            height: 5.0,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  pickLibrary(context);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Icon(EvaIcons.imageOutline)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        tr("library"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  pickCamera(context);
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Icon(EvaIcons.cameraOutline)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(tr("camera"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container()
                        ]))),
          );
        });
  }

  Widget _getActionButtons(BuildContext context, String image) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(tr("save")),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  print("id ${pref.getString("id")}");
                  BlocProvider.of<ProfileBloc>(context).add(UpdateEvent(
                      id: pref.getString("id"),
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      image: image,
                      token: pref.getString("token")));
                  setState(() {
                    _status = true;
                    //   FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(tr("cancel")),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
