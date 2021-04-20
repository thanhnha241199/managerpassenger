import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/payment/model/card.dart';
import 'package:managepassengercar/utils/config.dart';

class PaymentRepository {
  Future<List<CardModel>> fetchCard(String id) async {
    List<CardModel> card = [];
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}getcard", data: {"id": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => card.add(CardModel.fromJson(ad))).toList();
      return card;
    }
  }

  Future<String> deleteCard(
    String id,
  ) async {
    Map data = {'id': id};
    print("data ${data}");
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}deletecard", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> addCard(
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    String showBackView,
    String id,
  ) async {
    Map data = {
      'uid': id,
      'cardNumber': cardNumber,
      "expiryDate": expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
      "showBackView": showBackView
    };
    print("data ${data}");
    Response response =
        await Dio().post("${ServerAddress.serveraddress}addcard", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
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
    Response response =
        await Dio().post("${ServerAddress.serveraddress}addorder", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
