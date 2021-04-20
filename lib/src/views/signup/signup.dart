import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/src/views/otp/otp_page.dart';
import 'package:managepassengercar/src/views/signin/signin.dart';
import 'package:managepassengercar/src/views/widget/loading.dart';
import 'package:managepassengercar/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  bool _isLoading = false;
  signUp(String email, String pass, String name, String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass, 'name': name, 'phone': phone};
    var jsonResponse = null;
    var response =
        await http.post(Uri.parse("${ServerAddress.serveraddress}confirm"), body: data);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => OTPPage(email: email,password: pass,name: name,phone: phone,otp: jsonResponse['otp'].toString(),)));
      }
    } else {
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
          fontSize: 16);
    }
  }

  // Build an alert dialog to display some errors.
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 260.0,
              height: 230.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          // padding: new EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Login Error',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // dialog centre
                  new Expanded(
                    child: Center(
                        child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    )),
                    flex: 2,
                  ),
                  new Expanded(
                    child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";
  String _registerName = "";
  String _registerPhone = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;
  FocusNode _nameFocusNode;
  FocusNode _phoneFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    emailController.text = "nha@gmail.com";
    passwordController.text = "123456";
    nameController.text = "nha huynnh";
    phoneController.text = "123456";
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

//  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                        "Create A New Account",
                        textAlign: TextAlign.center,
                        //style: Constants.boldHeading,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
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
                                controller: emailController,
                                hintText: "Email...",
                                onChanged: (value) {
                                  _registerEmail = value;
                                },
                                onSubmitted: (value) {
                                  _passwordFocusNode.requestFocus();
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              CustomInput(
                                controller: passwordController,
                                hintText: "Password...",
                                onChanged: (value) {
                                  _registerPassword = value;
                                },
                                focusNode: _passwordFocusNode,
                                isPasswordField: true,
                                textInputAction: TextInputAction.next,
                              ),
                              CustomInput(
                                controller: nameController,
                                hintText: "Name...",
                                onChanged: (value) {
                                  _registerName = value;
                                },
                                focusNode: _nameFocusNode,
                                textInputAction: TextInputAction.next,
                              ),
                              CustomInput(
                                controller: phoneController,
                                hintText: "Phone...",
                                onChanged: (value) {
                                  _registerPhone = value;
                                },
                                focusNode: _phoneFocusNode,
                                textInputType: TextInputType.number,
                                onSubmitted: (value) {
                                  //  _submitForm();
                                },
                              ),
                              CustomBtn(
                                text: "Create New Account",
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  signUp(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                      phoneController.text);
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: CustomBtn(
                              text: "Back To Login",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              outlineBtn: true,
                            ),
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
