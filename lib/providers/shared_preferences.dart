import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  Future<void> setSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("seen", true);
  }

  Future<bool> getSeen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    return seen;
  }
}