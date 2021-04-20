import 'package:dio/dio.dart';
import 'package:managepassengercar/src/views/chat/user.dart';
import 'package:managepassengercar/utils/config.dart';

class ChatRepository {
  Future<List<UserChat>> fetchUser() async {
    List<UserChat> user = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getuser");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => user.add(UserChat.fromJson(ad))).toList();
      return user;
    }
  }
}
