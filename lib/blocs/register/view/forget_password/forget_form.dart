import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/blocs/register/view/forget_password/otp_forget/otpforget_page.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/repository/user_repository.dart';

class ForgetPass extends StatefulWidget {
  final UserRepository userRepository;

  ForgetPass({Key key, @required this.userRepository}) : super(key: key);

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController emailController = new TextEditingController();

  FocusNode _forgetFocusNode;

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ForgetConfirm) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPPage(userRepository: widget.userRepository)));
        }
        if (state is ForgetFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Email không tồn tại!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
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
                    SizedBox(
                      height: 200,
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
                              ),
                              state is LoginLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomBtn(
                                      text: "Send",
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                            ForgetButtonPressed(
                                                email: emailController.text));
                                      },
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
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
        },
      ),
    );
  }
}
