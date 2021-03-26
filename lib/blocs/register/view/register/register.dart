import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/register/bloc/register_bloc.dart';
import 'package:managepassengercar/blocs/register/view/register/register_form.dart';
import 'package:managepassengercar/repository/user_repository.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(userRepository: userRepository),
      ),
    );
  }
}
