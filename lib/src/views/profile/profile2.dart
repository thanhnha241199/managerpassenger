import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managepassengercar/src/views/profile/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///D:/Flutter/managepassengercar/lib/src/views/widget/blur_dialog.dart';

class Profile extends StatelessWidget {
  final String user;

  Profile({this.user});

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (controller) {

          // return Scaffold(
          //   resizeToAvoidBottomPadding: false,
          //   appBar: AppBar(
          //     centerTitle: false,
          //     title: Text(
          //       "Profile",
          //       style: TextStyle(
          //         color: Colors.black,
          //       ),
          //     ),
          //     backgroundColor: Colors.white,
          //     brightness: Brightness.light,
          //     elevation: 0,
          //     actionsIconTheme: IconThemeData(color: Colors.black),
          //     iconTheme: IconThemeData(color: Colors.black),
          //     actions: <Widget>[
          //       IconButton(
          //         onPressed: () {
          //           // Navigator.push(context,
          //           //     MaterialPageRoute(builder: (context) => CartScreen()));
          //         },
          //         icon: Icon(EvaIcons.settingsOutline),
          //       ),
          //     ],
          //   ),
          //   body: SingleChildScrollView(
          //     physics: BouncingScrollPhysics(),
          //     child: Column(
          //       children: [
          //         controller.check == null ?
          //         GestureDetector(
          //           onTap: () {
          //             Get.toNamed("/Login");
          //           },
          //           child: ListTile(
          //             contentPadding:
          //             EdgeInsets.symmetric(vertical: 10.0),
          //             title: Text(
          //               'Welcome',
          //               style: TextStyle(
          //                   fontSize: 22.0,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             subtitle: Text("Login/Register",
          //               style: TextStyle(
          //                   fontSize: 26.0,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             leading: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: CircleAvatar(
          //                 backgroundImage:
          //                 NetworkImage('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
          //               ),
          //             ),
          //             trailing: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Icon(Icons.keyboard_arrow_right),
          //             ),
          //           ),
          //         ) :
          //         GestureDetector(
          //           onTap: () {
          //             Get.toNamed("/userprofile");
          //           },
          //           child: ListTile(
          //             contentPadding:
          //             EdgeInsets.symmetric(vertical: 10.0),
          //             title: Text(
          //               'Welcome',
          //               style: TextStyle(
          //                   fontSize: 22.0,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             subtitle: Text("${controller.check}",
          //               overflow: TextOverflow.ellipsis,
          //               style: TextStyle(
          //                   fontSize: 26.0,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             leading: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: CircleAvatar(
          //                 backgroundImage:
          //                 NetworkImage('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
          //               ),
          //             ),
          //             trailing: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Icon(Icons.keyboard_arrow_right),
          //             ),
          //           ),
          //         ),
          //         Column(
          //           children: [
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Quan ly don hang"),
          //                         leading: Icon(
          //                           EvaIcons.archiveOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {
          //                         // Navigator.push(
          //                         //     context,
          //                         //     MaterialPageRoute(
          //                         //         builder: (context) => ManageOrder()));
          //                       }),
          //                   SizedBox(
          //                     height: (10.0),
          //                     child: Container(
          //                       color: Color(0xFFf5f6f7),
          //                     ),
          //                   ),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Don the nap"),
          //                         leading: Icon(
          //                           EvaIcons.browserOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {}),
          //                   Divider(),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Mua lan nua"),
          //                         leading: Icon(
          //                           EvaIcons.flip2Outline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {}),
          //                   SizedBox(
          //                     height: 10.0,
          //                     child: Container(
          //                       color: Color(0xFFf5f6f7),
          //                     ),
          //                   ),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Da thich"),
          //                         leading: Icon(
          //                           EvaIcons.heartOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {
          //                         // Navigator.push(
          //                         //     context,
          //                         //     MaterialPageRoute(
          //                         //         builder: (context) => SavedTab()));
          //                       }),
          //                   Divider(),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Vua xem"),
          //                         leading: Icon(
          //                           EvaIcons.loaderOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {}),
          //                   Divider(),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Vi airpay"),
          //                         leading: Icon(
          //                           EvaIcons.toggleRightOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {}),
          //                   Divider(),
          //                   //replyNotification(),
          //                 ])),
          //             Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Change Password"),
          //                         leading: Icon(
          //                           EvaIcons.toggleLeftOutline,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {
          //                       }),
          //                   Divider(),
          //                   //replyNotification(),
          //                 ])),
          //                 controller.check == null ? Text(""): Container(
          //                 height: 60,
          //                 child: Stack(children: <Widget>[
          //                   GestureDetector(
          //                       child: ListTile(
          //                         contentPadding: EdgeInsets.all(8),
          //                         title: Text("Logout"),
          //                         leading: Icon(
          //                           EvaIcons.logOut,
          //                         ),
          //                         trailing: Icon(Icons.keyboard_arrow_right),
          //                       ),
          //                       onTap: () {
          //                         // _showDialog(context);
          //                         //  _modalBottomSheetMenu4(context);
          //                         final action = CupertinoActionSheet(
          //                           message: Text(
          //                             "Bạn có muốn đăng xuất ?",
          //                             style: TextStyle(fontSize: 15.0),
          //                           ),
          //                           actions: <Widget>[
          //                             CupertinoActionSheetAction(
          //                               child: Text("Đăng xuất"),
          //                               isDestructiveAction: true,
          //                               onPressed: () {
          //                                 controller.logout();
          //                               },
          //                             )
          //                           ],
          //                           cancelButton: CupertinoActionSheetAction(
          //                             child: Text("Cancel"),
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                             },
          //                           ),
          //                         );
          //                         showCupertinoModalPopup(
          //                             context: context, builder: (context) => action);
          //                       }),
          //                   SizedBox(
          //                     height: (10.0),
          //                     child: Container(
          //                       color: Color(0xFFf5f6f7),
          //                     ),
          //                   ),
          //                 ])),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // );
        });
  }


}
