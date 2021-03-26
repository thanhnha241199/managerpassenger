import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/register/bloc/register_bloc.dart';
import 'package:managepassengercar/blocs/register/view/confirm_otp/otp_form.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  final UserRepository userRepository;

  OTPPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool reset;
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
    reset = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return RegisterBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: widget.userRepository,
        );
      },
      child: Center(
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
                  ),
                  Text("We sent your email: ${email}"),
                  reset ? buildTimer(10) : buildTimer(70),
                  OtpForm(userRepository: widget.userRepository),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
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
    ));
  }

  Row buildTimer(int time) {
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
