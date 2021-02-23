import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:managepassengercar/src/models/address.dart';
import 'package:managepassengercar/src/views/savelocation/form_location.dart';

class SaveLocation extends StatefulWidget {
  @override
  _SaveLocationState createState() => _SaveLocationState();
}

class _SaveLocationState extends State<SaveLocation> {
  var loading = false;
  List<Address> listModel = [];

  Future<Address> fetchAddress() async {
    setState(() {
      loading = true;
    });
    Map data = {
      'uid': '603315cf7c9ba513e47d3e28',
    };
    final response = await http
        .post('https://managerpassenger.herokuapp.com/getaddress', body: data);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data) {
          listModel.add(Address.fromJson(i));
        }
        loading = false;
      });
      return Address.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Address> futureAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAddress = fetchAddress();
    print(futureAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Địa điểm đã lưu",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/addlocation");
            },
            icon: Icon(EvaIcons.arrowheadDown),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text("Location favorite")),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: listModel.length,
                      itemBuilder: (context, i) {
                        final nDataList = listModel[i];
                        return AddressContainer(nDataList.title, nDataList.address,nDataList.id);
                      }),
            ),
          ),
        ],
      ),
    );
  }

  Widget AddressContainer(String title,String subtitle, String id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(EvaIcons.homeOutline),
          trailing: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormLocation(title: title,address: subtitle,uid: '603315cf7c9ba513e47d3e28',id: id,)));
            },
            child: Column(
              children: [Icon(EvaIcons.edit2Outline), Text("Edit")],
            ),
          ),
        ),
      ),
    );
  }
}
