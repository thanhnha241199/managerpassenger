import 'package:dio/dio.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/seat.dart';

class TicketRepository {
  Future<List<TourBus>> fetchTourbus() async {
    List<TourBus> tourbus = [];
    Response response =
        await Dio().get("https://managerpassenger.herokuapp.com/gettourbus");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => tourbus.add(TourBus.fromJson(ad))).toList();
      return tourbus;
    }
  }

  Future<List<TourBus>> fetchOneTourbus(String id) async {
    List<TourBus> tourbus = [];
    Response response = await Dio().get(
        "https://managerpassenger.herokuapp.com/gettourbus",
        queryParameters: {"id": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => tourbus.add(TourBus.fromJson(ad))).toList();
      return tourbus;
    }
  }

  Future<List<Seat>> fetchSeat(String id) async {
    List<Seat> seat = [];
    Response response = await Dio().get(
        "https://managerpassenger.herokuapp.com/getseat",
        queryParameters: {"idtour": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => seat.add(Seat.fromJson(ad))).toList();
      return seat;
    }
  }

  Future<List<PickUp>> fetchData(String id) async {
    List<PickUp> pickup = [];
    Response response = await Dio().get(
        "https://managerpassenger.herokuapp.com/getpickup",
        queryParameters: {"idtour": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => pickup.add(PickUp.fromJson(ad))).toList();
      return pickup;
    }
  }

  Future<String> addOrder(
      String uid,
      String name,
      String phone,
      String email,
      String idtour,
      String time,
      String locationstart,
      String quantyseat,
      String seat,
      String price,
      String totalprice) async {
    Map data = {
      "uid": uid,
      "name": name,
      "phone": phone,
      "email": email,
      "tour": idtour,
      "timetour": time,
      "location": locationstart,
      "quantity": quantyseat,
      "seat": seat,
      "price": price,
      "totalprice": totalprice
    };
    print(data);
    Response response = await Dio()
        .post("https://managerpassenger.herokuapp.com/addorder", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
