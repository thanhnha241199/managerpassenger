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
class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
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
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // dialog centre
                  new Expanded(
                    child: Center(
                        child: Text(error,
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
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: GestureDetector(
                        onTap: (){
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
        }
    );
  }
  // Default Form Loading State
  bool _isLoading = false;
  forget(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
    };
    var jsonResponse = null;
    var response = await http.post("https://managerpassenger.herokuapp.com/forgetpass", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: 'Forget success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OTPPage(email: email,otp: jsonResponse['otp'].toString(),)), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'Forget failed',
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
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          controller: emailController,
                          hintText: "Email...",
                          onChanged: (value) {
                            _forgetEmail = value;
                            if(_forgetEmail.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            }
                          },
                          onSubmitted: (value) {
                            _forgetFocusNode.requestFocus();
                            if(value.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            }
                          },
                        ),
                        CustomBtn(
                          text: "Send",
                          onPressed: (){
                            if(_forgetEmail.isEmpty){
                              _alertDialogBuilder("Nhap email");
                            } else{
                              setState(() {
                                _isLoading = true;
                              });
                              forget(emailController.text);
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
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
