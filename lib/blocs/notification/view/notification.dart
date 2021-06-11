import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:managepassengercar/blocs/notification/bloc/notification_bloc.dart';
import 'package:managepassengercar/main.dart';
import 'package:managepassengercar/utils/app_style.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String messageTitle = "Không có thông báo nào!";
  String notificationAlert = "Thông báo";

  @override
  void initState() {
    getToken();
    BlocProvider.of<NotificationBloc>(context).add(DoFetchEvent());
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
  }

  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Thông báo",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
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
                    colors: [Colors.blue[400], Colors.blue[900]])),
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: BlocBuilder<NotificationBloc, NotificationState>(
                buildWhen: (previous, current) {
                  if (previous is SuccessState) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SuccessState) {
                    return state.notification.length == 0
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/small_icon/notification.png",
                                  height: 250.0,
                                  width: 250.0,
                                ),
                                Text(
                                    "Hiện tại, bạn không có thông báo mới nào.",
                                    style: AppTextStyles.textSize20(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white)),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        notificationAlert,
                                      ),
                                      Text(
                                        messageTitle,
                                        style: AppTextStyles.textSize18(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: state.notification.length,
                              padding: EdgeInsets.only(top: 0),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Colors.green.withOpacity(0.3),
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.green,
                                    ),
                                  ),
                                  title: Text(
                                    "Đơn hành ${state.notification[index].title} đã được tạo",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.notification[index].time
                                            .toString()
                                            .substring(0, 16),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Hệ thống sẽ tìm kiếm và phản hồi thông tin sau 30 phút!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
