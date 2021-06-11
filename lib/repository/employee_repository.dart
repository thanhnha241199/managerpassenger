import 'package:dio/dio.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/profile_user.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/models/seat.dart';
import 'package:managepassengercar/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:managepassengercar/src/models/order.dart';

class EmployeeRepository {
  Future<List<TourBus>> fetchTourbus() async {
    List<TourBus> tourbus = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}gettourbus");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => tourbus.add(TourBus.fromJson(ad))).toList();
      return tourbus;
    }
  }

  Future<List<ListOrder>> fetchOrderTicket() async {
    List<ListOrder> ticketorder = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getorder");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => ticketorder.add(ListOrder.fromJson(ad))).toList();
      return ticketorder;
    }
  }

  Future<List<PickUp>> fetchPickUp() async {
    List<PickUp> pickup = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getpickup");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => pickup.add(PickUp.fromJson(ad))).toList();
      return pickup;
    }
  }

  Future<List<Schedule>> fetchSchedule() async {
    List<Schedule> schedule = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getschedule");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => schedule.add(Schedule.fromJson(ad))).toList();
      return schedule;
    }
  }

  Future<List<Seat>> fetchSeat() async {
    List<Seat> seat = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getseat");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => seat.add(Seat.fromJson(ad))).toList();
      return seat;
    }
  }

  Future<ProfileUser> fetchProfileUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Dio dio = new Dio();
    ProfileUser profileUser;
    dio.options.headers['Authorization'] = 'Bearer ${token}';
    Response response = await dio.get("${ServerAddress.serveraddress}getinfo");
    if (response != null && response.statusCode == 200) {
      profileUser = ProfileUser.fromJson(response.data);
      return profileUser;
    }
  }
}
