import 'package:dio/dio.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/model/addressmodel.dart';
import 'package:managepassengercar/src/models/address.dart';

class AddressRepository {
  Future<List<Address>> fetchAddress() async {
    List<Address> address = [];
    Map data = {
      'uid': '603315cf7c9ba513e47d3e28',
    };
    Response response =
        await Dio().get("https://managerpassenger.herokuapp.com/getaddress");

    if (response != null && response.statusCode == 200) {
      var data = response.data;
      data.map((ad) => address.add(Address.fromJson(ad))).toList();
      return address;
    }
  }

  Future<List<AddressModel>> fetchAddressModel() async {
    List<AddressModel> address = [];
    Map data = {
      'uid': '603315cf7c9ba513e47d3e28',
    };
    Response response =
        await Dio().get("https://managerpassenger.herokuapp.com/addressmodel");
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
        .post("https://managerpassenger.herokuapp.com/addaddress", data: data);
    print(response);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> updateAddress(String id, String title, String address) async {
    Map data = {'id': id, 'title': title, "address": address};
    Response response = await Dio().post(
        "https://managerpassenger.herokuapp.com/updateaddress",
        data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }

  Future<String> deleteAddress(String id) async {
    Map data = {'id': id};
    Response response = await Dio().post(
        "https://managerpassenger.herokuapp.com/deleteaddress",
        data: data);
    if (response != null && response.statusCode == 200) {
      var data = response.data;
      return data['success'].toString();
    }
  }
}
