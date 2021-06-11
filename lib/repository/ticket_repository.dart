import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/src/models/orderstatus.dart';
import 'package:managepassengercar/src/models/pickup.dart';
import 'package:managepassengercar/src/models/seat.dart';
import 'package:managepassengercar/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketRepository {
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

  Future<List<TourBus>> fetchOneTourbus(String id) async {
    List<TourBus> tourbus = [];
    Response response = await Dio().get(
        "${ServerAddress.serveraddress}gettourbus",
        queryParameters: {"id": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => tourbus.add(TourBus.fromJson(ad))).toList();
      return tourbus;
    }
  }

  Future<List<Seat>> fetchSeat(String id) async {
    List<Seat> seat = [];
    Response response = await Dio().get("${ServerAddress.serveraddress}getseat",
        queryParameters: {"idtour": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => seat.add(Seat.fromJson(ad))).toList();
      return seat;
    }
  }

  Future<List<Discount>> fetchDiscount() async {
    List<Discount> seat = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}getdiscount");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => seat.add(Discount.fromJson(ad))).toList();
      return seat;
    }
  }

  Future<List<Address>> fetchAddress() async {
    List<Address> address = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    Response response = await Dio().get(
        "${ServerAddress.serveraddress}getaddress?uid=${pref.getString('id')}");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => address.add(Address.fromJson(ad))).toList();
      return address;
    }
  }

  Future<List<Order>> fetchOrder() async {
    List<Order> order = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    Response response = await Dio().get(
        "${ServerAddress.serveraddress}getorderuser",
        queryParameters: {"id": pref.getString('id')});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => order.add(Order.fromJson(ad))).toList();
      return order;
    }
  }

  Future<List<PickUp>> fetchData(String id) async {
    List<PickUp> pickup = [];
    Response response = await Dio().get(
        "${ServerAddress.serveraddress}getpickup",
        queryParameters: {"idtour": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => pickup.add(PickUp.fromJson(ad))).toList();
      return pickup;
    }
  }

  Future<OrderStatus> addOrder(
    String uid,
    String name,
    String phone,
    String email,
    String qr,
    String idtour,
    String time,
    String locationstart,
    String quantyseat,
    String seat,
    String price,
    String totalprice,
    String paymentType,
  ) async {
    Map data = {
      "uid": uid,
      "name": name,
      "phone": phone,
      "email": email,
      "qr": qr,
      "status": "order",
      "tour": idtour,
      "timetour": time,
      "location": locationstart,
      "quantity": quantyseat,
      "seat": seat,
      "price": price,
      "totalprice": totalprice,
      "paymentType": paymentType,
    };
    OrderStatus orderStatus;
    Response response =
        await Dio().post("${ServerAddress.serveraddress}addorder", data: data);
    if (response != null && response.statusCode == 200) {
      orderStatus = OrderStatus.fromJson(response.data);
      return orderStatus;
    }
  }

  Future<String> addNoti(String id, String title, String description) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {
      "id": id,
      "title": pref.getString("orderID"),
      "description": description
    };

    Response response =
        await Dio().post("${ServerAddress.serveraddress}addnoti", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> changeorder(String id, String status) async {
    Map data = {"id": id, "status": status};

    Response response = await Dio()
        .post("${ServerAddress.serveraddress}updateOrder", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> reviewTourBus(
      String id, String rating, String description) async {
    Map data = {"id": id, "rating": rating, "description": description};
    print(data);
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}updateRatingtourbus", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> sendMail(
      String name,
      String phone,
      String email,
      String idtour,
      String time,
      String locationstart,
      String quantyseat,
      String seat,
      String price,
      String orderID,
      String totalprice) async {
    Map data = {
      "name": name,
      "phone": phone,
      "email": email,
      "tour": idtour,
      "timetour": time,
      "location": locationstart,
      "quantity": quantyseat,
      "seat": seat,
      "price": price,
      "orderID": orderID,
      "totalprice": totalprice
    };
    print(data);
    Response response =
        await Dio().post("${ServerAddress.serveraddress}sendmail", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> sendNoti(String token, String title, String body) async {
    Map data = {"title": title, "token": token, "body": body};
    print(data);
    Response response =
        await Dio().post("${ServerAddress.serveraddress}sendnoti", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
