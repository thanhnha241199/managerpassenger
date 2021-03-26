import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormForget extends StatefulWidget {
  final UserRepository userRepository;

  FormForget({Key key, @required this.userRepository}) : super(key: key);

  @override
  _FormForgetState createState() => _FormForgetState();
}

class _FormForgetState extends State<FormForget> {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ForgetFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('error'),
            backgroundColor: Colors.red,
          ));
        }
        if (state is ForgetSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Success(
                      title: "Sign Up Successfull",
                      page: LoginPage(userRepository: widget.userRepository))),
              (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
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
                          state is LoginLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomBtn(
                                  text: "Confirm",
                                  onPressed: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(ChangeButtonPressed(
                                      email: pref.getString("email"),
                                      password: passwordController.text,
                                    ));
                                    print(
                                        "${pref.getString("email")} +${passwordController.text}");
                                  },
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
          );
        },
      ),
    );
  }
}
