// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _fcm;
//
//   PushNotificationService(this._fcm);
//
//   Future initialise() async {
//     if (Platform.isIOS) {
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }
//
//     String token = await _fcm.getToken();
//     print("FirebaseMessaging token: $token");
//
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//       onBackgroundMessage: (Map<String, dynamic> message) async {
//         print("backgroundMessage: $message");
//       },
//     );
//   }
// }
