import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/register/bloc/register_bloc.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';

class OtpForm extends StatefulWidget {
  String email, password, name, phone;
  final UserRepository userRepository;

  OtpForm({Key key, @required this.userRepository}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

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

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  final TextEditingController controller1 = new TextEditingController();
  final TextEditingController controller2 = new TextEditingController();
  final TextEditingController controller3 = new TextEditingController();
  final TextEditingController controller4 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (state.confirmFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('OTP sai'),
          backgroundColor: Colors.red,
        ));
      }
      if (state.confirmSuccess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Success(
                    title: "Sign Up Successfull",
                    page: LoginPage(userRepository: widget.userRepository))),
            (route) => false);
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SafeArea(
          child: Form(
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
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                state.isSubmitting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : DefaultButton(
                        text: "Continue",
                        press: () {
                          BlocProvider.of<RegisterBloc>(context).add(ConfirmOTP(
                              otp: controller1.text +
                                  controller2.text +
                                  controller3.text +
                                  controller4.text));
                        },
                      )
              ],
            ),
          ),
        );
      },
    ));
  }
}
