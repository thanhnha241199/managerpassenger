import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var check;

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('token');
    check = status;
    update();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    checkUser();
    Get.offNamed("/home");
    Get.back();
    Get.snackbar(
      "Notification!", // title
      "Logout successfull!", // message
      icon: Icon(Icons.check),
      barBlur: 100,
      snackPosition: SnackPosition.BOTTOM,
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUser();
  }
}
