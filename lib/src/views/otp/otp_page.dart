import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class OTPPage extends StatefulWidget {
  String email, password, name, phone, otp;

  OTPPage({this.email, this.password, this.name, this.phone, this.otp});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    "OTP Verification",
                    // style: headingStyle,
                  ),
                  Text("We sent your email: ${widget.email}"),
                  buildTimer(),
                  OtpForm(otp: widget.otp,email: widget.email,password: widget.password, name: widget.name,phone: widget.phone,),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // OTP code resend
                    },
                    child: Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

class OtpForm extends StatefulWidget {
  String email, password, name, phone, otp;
  OtpForm({
    Key key, this.email, this.password, this.name, this.phone, this.otp
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  String OTP;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }
  bool _isLoading = false;
  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }
  confirm(String email,String pass,String name,String phone) async {
    OTP = controller1.text + controller2.text +controller3.text +controller4.text;
    var check = OTP.compareTo(widget.otp);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass,
      'name': name,
      'phone': phone
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/adduser", body: data);
    print(check.toString());
    if(check == 0){
      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if(jsonResponse != null) {
          setState(() {
            _isLoading = false;
            var a= sharedPreferences.setString("token", jsonResponse['token']);
          });
          Fluttertoast.showToast(
              msg: 'Successfull',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Success(title: "Sign Up Successfull!!!",page: "/login",)));
        }
      }
      else {
        print("failed");
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
    }else{
      Fluttertoast.showToast(
          msg: 'OTP Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16
      );
    }

  }
  final TextEditingController controller1 = new TextEditingController();
  final TextEditingController controller2 = new TextEditingController();
  final TextEditingController controller3 = new TextEditingController();
  final TextEditingController controller4 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: controller1,
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                    OTP = OTP + value.toString();
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: controller2,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin3FocusNode);
                    OTP = OTP + value.toString();
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: controller3,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value, pin4FocusNode);
                    OTP = OTP + value.toString();
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: controller4,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode.unfocus();
                    }
                    OTP = OTP + value.toString();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          DefaultButton(
            text: "Continue",
            press: () {
              print("${widget.email}");
              confirm(widget.email, widget.password, widget.name, widget.phone);
            },
          )
        ],
      ),
    );
  }
}
