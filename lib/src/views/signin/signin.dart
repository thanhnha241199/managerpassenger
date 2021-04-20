import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/signin/authenticate.dart';
import 'package:managepassengercar/src/views/widget/loading.dart';
import 'package:managepassengercar/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;
    var response = await http.post(Uri.parse("${ServerAddress.serveraddress}authenticate"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
          sharedPreferences.setString("token", jsonResponse['token']);
        });
        Fluttertoast.showToast(
            msg: 'Authenticated',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      Fluttertoast.showToast(
          msg: 'UnAuthenticated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16);
    }
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
  var name, password, token;

  // Focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<String> _loginAccount() async {
    AuthSevice().login(name, password).then((value) {
      if (value.data['success']) {
        token = value.data['token'];
        Fluttertoast.showToast(
            msg: 'Authenticated',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _isLoading
          ? Loading()
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50.0, bottom: 10),
                        child: Text(
                          "Welcome User,\nLogin to your account",
                          textAlign: TextAlign.center,
                          style: Constants.boldHeading,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
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
                                    name = value;
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
                                    password = value;
                                  },
                                  focusNode: _passwordFocusNode,
                                  isPasswordField: true,
                                  onSubmitted: (value) {},
                                ),
                                CustomBtn(
                                    text: "Login",
                                    onPressed: emailController.text == "" ||
                                            passwordController.text == ""
                                        ? null
                                        : () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            signIn(emailController.text,
                                                passwordController.text);
                                          })
                              ],
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/forget");
                              },
                              child: Text("Forget password?"),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              child: CustomBtn(
                                text: "Create New Account",
                                onPressed: () {
                                  Navigator.pushNamed(context, "/signup");
                                },
                                outlineBtn: true,
                              ),
                            ),
                            Text("Or"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton(
                                  onPressed: () {},
                                  child: Text("Google"),
                                ),
                                FlatButton(
                                  onPressed: () {},
                                  child: Text("Facebook"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
