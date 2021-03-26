import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';

import 'package:managepassengercar/src/views/widget/loading.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:http/http.dart' as http;

class FormChangePassword extends StatefulWidget {
  String email;
  FormChangePassword({this.email});
  @override
  _FormChangePasswordState createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  bool _isLoading = false;
  changepass(String oldpassword, String newpassword) async {
    Map data = {
      'email': "nha@gmail.com",
      'oldpassword': oldpassword,
      'newpassword': newpassword,
    };
    var jsonResponse = null;
    var response = await http.post(
        "https://managerpassenger.herokuapp.com/changepassword",
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: 'Change success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Success(
                      title: "ChangePass Successfull!!!",
                      page: HomePage(),
                    )),
            (Route<dynamic> route) => false);
      }
    } else {
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
          fontSize: 16);
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

  final TextEditingController oldpasswordController =
      new TextEditingController();
  final TextEditingController newpasswordController =
      new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  FocusNode _newpasswordFocusNode;
  FocusNode _oldpasswordFocusNode;
  FocusNode _confirmpasswordFocusNode;
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: _isLoading
          ? Loading()
          : SafeArea(
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
                                controller: oldpasswordController,
                                hintText: "Old Password...",
                                focusNode: _oldpasswordFocusNode,
                                isPasswordField: true,
                                textInputAction: TextInputAction.next,
                              ),
                              CustomInput(
                                controller: newpasswordController,
                                hintText: "New Password...",
                                focusNode: _newpasswordFocusNode,
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
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  print(oldpasswordController.text);
                                  print(newpasswordController.text);
                                  newpasswordController.text.compareTo(
                                              confirmpasswordController.text) ==
                                          0
                                      ? changepass(oldpasswordController.text,
                                          newpasswordController.text)
                                      : print("AAA");
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 150,
                          ),
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
