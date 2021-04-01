import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/payment/model/card.dart';

class PaymentRepository {
  Future<List<CardModel>> fetchCard(String id) async {
    List<CardModel> card = [];
    Response response = await Dio().post(
        "https://managerpassenger.herokuapp.com/getcard",
        data: {"id": id});
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      print(data);
      data.map((ad) => card.add(CardModel.fromJson(ad))).toList();
      return card;
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
    Response response = await Dio()
        .post("https://managerpassenger.herokuapp.com/addcard", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
