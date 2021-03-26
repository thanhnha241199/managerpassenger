import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/employee/view/employee.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/blocs/register/view/forget_password/forget_password.dart';
import 'package:managepassengercar/blocs/register/view/register/register.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input_password.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/chat/global.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  LoginForm({this.userRepository});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  var name, password, token;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode?.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailture) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Tài khoản hoặc mật khẩu không chính xác!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is LoginNull) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Tài khoản hoặc mật khẩu không được để trống!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is LoginUserSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userRepository: widget.userRepository)),
              (route) => false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Đăng nhập thành công!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            backgroundColor: Colors.green,
          ));
        }
        if (state is LoginEmployeeSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Employee(userRepository: widget.userRepository)),
              (route) => false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Đăng nhập thành công!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
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
                    height: MediaQuery.of(context).size.height * 0.7,
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
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            CustomInputPassword(
                                passwordVisible: false,
                                controller: passwordController,
                                hintText: "Password...",
                                onChanged: (value) {
                                  password = value;
                                },
                                focusNode: _passwordFocusNode),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(""),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgetPage(
                                                  userRepository:
                                                      widget.userRepository,
                                                )));
                                  },
                                  child: Text(
                                    "Forget password?",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            state is LoginLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomBtn(
                                    text: "Login",
                                    onPressed: () {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(LoginButtonPressed(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ));
                                    })
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: CustomBtn(
                            text: "Create New Account",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage(
                                          userRepository:
                                              widget.userRepository)));
                            },
                            outlineBtn: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          EvaIcons.googleOutline,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("Google",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.green),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          EvaIcons.facebookOutline,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("Facebook",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
