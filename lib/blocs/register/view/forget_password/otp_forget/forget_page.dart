import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/blocs/register/view/forget_password/otp_forget/form-forget.dart';
import 'package:managepassengercar/repository/user_repository.dart';

class ForgetPage extends StatefulWidget {
  final UserRepository userRepository;

  ForgetPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                userRepository: widget.userRepository,
              );
            },
            child: FormForget(userRepository: widget.userRepository)));
  }
}
