import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
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
  FocusNode _forgetFocusNode;
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
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  FocusNode _passwordFocusNode;
  FocusNode _confirmpasswordFocusNode;
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      body: SafeArea(
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
