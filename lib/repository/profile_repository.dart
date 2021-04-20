import 'package:dio/dio.dart';
import 'package:managepassengercar/src/models/profile_user.dart';
import 'package:managepassengercar/utils/config.dart';

class ProfileRepository {
  Future<ProfileUser> fetchProfileUser(String token) async {
    Dio dio = new Dio();
    ProfileUser profileUser;
    dio.options.headers['Authorization'] = 'Bearer ${token}';
    Response response = await dio.get("${ServerAddress.serveraddress}getinfo");
    if (response != null && response.statusCode == 200) {
      profileUser = ProfileUser.fromJson(response.data);
      return profileUser;
    }
  }

  Future<String> updateProfile(
      String id, String name, String phone, String image) async {
    Map data = {"_id": id, 'name': name, 'phone': phone, 'image': image};
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}updateinfor", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print("res ${data}");
      return data['success'].toString();
    }
  }
}
