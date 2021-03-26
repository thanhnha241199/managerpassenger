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
      print("data ${data}");
      data.map((ad) => tourbus.add(TourBus.fromJson(ad))).toList();
      return tourbus;
    }
  }

  Future<List<Seat>> fetchSeat(String id) async {
    List<Seat> seat = [];
    Response response = await Dio().get(
        "https://managerpassenger.herokuapp.com/getseat",
        queryParameters: {"idtour": id});
    print("res : ${response}");
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
}
