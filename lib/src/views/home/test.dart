// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOs = IOSInitializationSettings();
//     var initSetttings = InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOs);
//
//     flutterLocalNotificationsPlugin.initialize(initSetttings,
//         onSelectNotification: onSelectNotification);
//   }
//
//   Future onSelectNotification(String payload) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return NewScreen(
//         payload: payload,
//       );
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: Colors.red,
//         title: new Text('Flutter notification demo'),
//       ),
//       body: new Center(
//         child: Column(
//           children: <Widget>[
//             RaisedButton(
//               onPressed: showNotification,
//               child: new Text(
//                 'showNotification',
//               ),
//             ),
//             RaisedButton(
//               onPressed: cancelNotification,
//               child: new Text(
//                 'cancelNotification',
//               ),
//             ),
//             RaisedButton(
//               onPressed: scheduleNotification,
//               child: new Text(
//                 'scheduleNotification',
//               ),
//             ),
//             RaisedButton(
//               onPressed: showBigPictureNotification,
//               child: new Text(
//                 'showBigPictureNotification',
//               ),
//             ),
//             RaisedButton(
//               onPressed: showNotificationMediaStyle,
//               child: new Text(
//                 'showNotificationMediaStyle',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> showNotificationMediaStyle() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'media channel id',
//       'media channel name',
//       'media channel description',
//       color: Colors.red,
//       enableLights: true,
//       largeIcon: DrawableResourceAndroidBitmap("flutter_devs"),
//       styleInformation: MediaStyleInformation(),
//     );
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'notification title', 'notification body', platformChannelSpecifics);
//   }
//
//   Future<void> showBigPictureNotification() async {
//     var bigPictureStyleInformation = BigPictureStyleInformation(
//         DrawableResourceAndroidBitmap("flutter_devs"),
//         largeIcon: DrawableResourceAndroidBitmap("flutter_devs"),
//         contentTitle: 'flutter devs',
//         htmlFormatContentTitle: true,
//         summaryText: 'summaryText',
//         htmlFormatSummaryText: true);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'big text channel id',
//         'big text channel name',
//         'big text channel description',
//         styleInformation: bigPictureStyleInformation);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics,
//         payload: "big image notifications");
//   }
//
//   // Future<void> scheduleNotification() async {
//   //   var scheduledNotificationDateTime =
//   //       DateTime.now().add(Duration(seconds: 5));
//   //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //     'channel id',
//   //     'channel name',
//   //     'channel description',
//   //     icon: 'flutter_devs',
//   //     largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
//   //   );
//   //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   //   var platformChannelSpecifics = NotificationDetails(
//   //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//   //   await flutterLocalNotificationsPlugin.schedule(
//   //       0,
//   //       'scheduled title',
//   //       'scheduled body',
//   //       scheduledNotificationDateTime,
//   //       platformChannelSpecifics);
//   // }
//   //
//   // Future<void> cancelNotification() async {
//   //   await flutterLocalNotificationsPlugin.cancel(0);
//   // }
//
// //  showNotification() async {
// //     var android = new AndroidNotificationDetails(
// //         'id', 'channel ', 'description',
// //         priority: Priority.High, importance: Importance.Max);
// //     var iOS = new IOSNotificationDetails();
// //     var platform = new NotificationDetails(android, iOS);
// //     await flutterLocalNotificationsPlugin.show(
// //         0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
// //         payload: 'Welcome to the Local Notification demo ');
// //   }
// }
//
// class NewScreen extends StatelessWidget {
//   String payload;
//
//   NewScreen({
//     @required this.payload,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(payload),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int present = 0;
//   int perPage = 14;
//   final originalItems = List<String>.generate(10000, (i) => "Item $i");
//   var items = List<String>();
//
//   @override
//   void initState() {
//     super.initState();
//     print("present: ${present}");
//     setState(() {
//       items.addAll(originalItems.getRange(present, present + perPage));
//       present = present + perPage;
//     });
//   }
//
//   void loadMore() async {
//     //  await new Future.delayed(new Duration(seconds: 1));
//
//     setState(() {
//       if ((present + perPage) > originalItems.length) {
//         items.addAll(originalItems.getRange(present, originalItems.length));
//         print("1");
//       } else {
//         items.addAll(originalItems.getRange(present, present + perPage));
//         print("2");
//       }
//       present = present + perPage;
//       print("present: ${present}");
//     });
//   }
//
//   bool _onScrollNotification(ScrollNotification notification) {
//     if (notification is ScrollEndNotification) {
//       final before = notification.metrics.pixels;
//       final max = notification.metrics.maxScrollExtent;
//       print("Before ${before}");
//       print(max);
//       if (before == max) {
//         loadMore();
//         print("load");
//       }
//     }
//     return false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("LoadMore"),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: _onScrollNotification,
//         child: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: (present <= originalItems.length)
//               ? items.length + 1
//               : items.length,
//           itemBuilder: (context, index) {
//             return (index == items.length)
//                 ? Container(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//                 : Container(
//                     color: Colors.red,
//                     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     height: MediaQuery.of(context).size.height / 4,
//                     child: ListTile(
//                       title: Text('${items[index]}'),
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';

// class Map extends StatefulWidget {
//   @override
//   _MapState createState() => _MapState();
// }

// class _MapState extends State<Map> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         RaisedButton(
//           onPressed: () async {
//             LocationResult result = await showLocationPicker(
//               context,
//               apiKey,
//               initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//               myLocationButtonEnabled: true,
//               // requiredGPS: true,
//               layersButtonEnabled: true,
//               // countries: ['AE', 'NG']

// //                      resultCardAlignment: Alignment.bottomCenter,
//               desiredAccuracy: LocationAccuracy.best,
//             );
//             print("result = $result");
//             setState(() => _pickedLocation = result);
//           },
//           child: Text('Pick location'),
//         ),
//         Text(_pickedLocation.toString()),
//       ],
//     ));
//   }
// }
