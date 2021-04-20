import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/model/addressmodel.dart';
import 'package:managepassengercar/src/models/address.dart';
import 'package:managepassengercar/utils/config.dart';

class AddressRepository {
  Future<List<Address>> fetchAddress(String id) async {
    List<Address> address = [];

    Response response =
        await Dio().get("${ServerAddress.serveraddress}getaddress?uid=${id}");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => address.add(Address.fromJson(ad))).toList();
      return address;
    }
  }

  Future<List<AddressModel>> fetchAddressModel() async {
    List<AddressModel> address = [];
    Response response =
        await Dio().get("${ServerAddress.serveraddress}addressmodel");
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => address.add(AddressModel.fromJson(ad))).toList();
      return address;
    }
  }

  Future<String> addAddress(String id, String title, String address) async {
    Map data = {'id': id, 'title': title, "address": address};
    print(data);
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}addaddress", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> updateAddress(String id, String title, String address) async {
    Map data = {'id': id, 'title': title, "address": address};
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}updateaddress", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> deleteAddress(String id) async {
    Map data = {'id': id};
    Response response = await Dio()
        .post("${ServerAddress.serveraddress}deleteaddress", data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
