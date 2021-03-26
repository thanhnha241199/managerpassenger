import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_form.dart';

class OTPPage extends StatefulWidget {
  final UserRepository userRepository;

  OTPPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String email;

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Scaffold(
        body: BlocProvider(create: (context) {
      return LoginBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        userRepository: widget.userRepository,
      );
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Center(
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
                    Text("We sent your email: ${email}"),
                    state is LoginLoading ? buildTimer(30) : buildTimer(60),
                    OtpForm(userRepository: widget.userRepository),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        BlocProvider.of<LoginBloc>(context).add(
                            ReconfirmButtonPressed(
                                email: pref.getString("email")));
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
        );
      },
    )));
  }

  Row buildTimer(time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: time, end: 0.0),
          duration: Duration(seconds: time),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
