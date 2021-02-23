import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:managepassengercar/src/views/widget/loading.dart';

class FormLocation extends StatefulWidget {
  String title;
  String address;
  String uid;
  String id;
  FormLocation({this.title, this.address, this.uid, this.id});
  @override
  _FormLocationState createState() => _FormLocationState();
}

class _FormLocationState extends State<FormLocation> {
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  bool _isLoading = false;
  addAddress(String id,String address,String name) async {
    Map data = {
      'id': id,
      'title': name,
      'address': address
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/addaddress", body: data);
    if(response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        Fluttertoast.showToast(
            msg: 'Success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16
        );
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/location");
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16
      );
    }
  }
  deleteAddress(String id) async {
    Map data = {
      'id': id,
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/deleteaddress", body: data);
    if(response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        Fluttertoast.showToast(
            msg: 'Success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16
        );
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/location");
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16
      );
    }
  }
  updateAddress(String id, String title, String address ) async {
    Map data = {
      'id': id,
      'title': title,
      "address": address
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/updateaddress", body: data);
    if(response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        Fluttertoast.showToast(
            msg: 'Success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16
        );
        Navigator.pop(context);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.text = widget.address ?? null;
    nameController.text = widget.title ?? null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "ADD LOCATION",
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
      ),
      body: _isLoading ? Loading() : Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  hintText: "Name location",
                  suffixIcon: Icon(EvaIcons.personDeleteOutline)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Address",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: "Address",
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Row(
          children: <Widget>[
            widget.address== null ? Text(""): Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _isLoading= true;
                  });
                  deleteAddress(widget.id);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text("Delete",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ),
            SizedBox(width: 5,),
            widget.address != null ? Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _isLoading= true;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(30)),
                  child: Text("Update",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ) : Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    _isLoading= true;
                  });
                  addAddress('603315cf7c9ba513e47d3e28',addressController.text, nameController.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(30)),
                  child: Text("Add",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
