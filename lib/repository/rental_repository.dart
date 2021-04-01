import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/rental/model/rental.dart';

class RentalRepository {
  Future<List<RentalOrder>> fetchRental(String id) async {
    List<RentalOrder> rental = [];
    Map data = {
      'id': id,
    };
    Response response = await Dio().post(
        "https://managerpassenger.herokuapp.com/getrentalorder",
        data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => rental.add(RentalOrder.fromJson(ad))).toList();
      return rental;
    }
  }

  Future<String> addOrder(
      String uid,
      String name,
      String phone,
      String email,
      String locationstart,
      String locationend,
      String timestart,
      String timeend,
      String quantyseat,
      String quanticus,
      String type,
      String note) async {
    Map data = {
      "uid": uid,
      "name": name,
      "phone": phone,
      "email": email,
      "timestart": timestart,
      "timeend": timeend,
      "locationstart": locationstart,
      "locationend": locationend,
      "quantityseat": quantyseat,
      "quanticus": quanticus,
      "typecar": type,
      "note": note
    };
    print(data);
    Response response = await Dio()
        .post("https://managerpassenger.herokuapp.com/addrental", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
