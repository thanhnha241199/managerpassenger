import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/notification/model/notification.dart';
import 'package:managepassengercar/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepository {
  Future<List<Notification>> fetchNotification() async {
    List<Notification> tourbus = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Response response = await Dio().get("${ServerAddress.serveraddress}getnoti",
        queryParameters: {"uid": preferences.getString("id")});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => tourbus.add(Notification.fromJson(ad))).toList();
      return tourbus;
    }
  }
}
