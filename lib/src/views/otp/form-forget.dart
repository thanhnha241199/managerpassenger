import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managepassengercar/src/views/otp/otpforget_page.dart';
import 'package:managepassengercar/src/views/signin/signin.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/loading.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class FormForget extends StatefulWidget {
  String email;
  FormForget({this.email});
  @override
  _FormForgetState createState() => _FormForgetState();
}

class _FormForgetState extends State<FormForget> {
  bool _isLoading = false;
  changepass(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/resetpassword", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: 'Change success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Success(title: "ChangePass Successfull!!!",page: "/login",)), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'Changepass failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16
      );
    }
  }
  bool _ForgetLoading = false;
  FocusNode _forgetFocusNode;
  // Form Input Field Values
  String _forgetEmail = "";
  @override
  void initState() {
    _forgetFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _forgetFocusNode.dispose();
    super.dispose();
  }
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController = new TextEditingController();
  FocusNode _passwordFocusNode;
  FocusNode _confirmpasswordFocusNode;
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _isLoading ? Loading() :SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 60.0,
                ),
                child: Text(
                  "Welcome User,\nYour Forget Password",
                  textAlign: TextAlign.center,
                //  style: Constants.boldHeading,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Color(0xFFDADADA).withOpacity(0.15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomInput(
                          controller: passwordController,
                          hintText: "Password...",
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          controller: confirmpasswordController,
                          hintText: "Confirm Password...",
                          isPasswordField: true,
                        ),
                        CustomBtn(
                          text: "Confirm",
                          onPressed: (){
                              setState(() {
                                _isLoading = true;
                              });
                              passwordController.text.compareTo(confirmpasswordController.text) == 0 ? changepass(widget.email,passwordController.text): print("AAA");
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 150,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
