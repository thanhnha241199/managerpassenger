import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/register/bloc/register_bloc.dart';
import 'package:managepassengercar/blocs/register/view/confirm_otp/otp_register.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_btn.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
import 'package:managepassengercar/repository/user_repository.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;

  RegisterForm({Key key, @required this.userRepository}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  bool _isLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";
  String _registerName = "";
  String _registerPhone = "";

  FocusNode _passwordFocusNode;
  FocusNode _nameFocusNode;
  FocusNode _phoneFocusNode;

  bool get isPopulated =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isValidEmailAndPassword && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (state.isFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Email đã tồn tại!'),
          backgroundColor: Colors.red,
        ));
      }
      if (state.isSuccess) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OTPPage(userRepository: widget.userRepository)));
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
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
                      "Create A New Account",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
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
                                _registerEmail = value;
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
                                _registerPassword = value;
                              },
                              focusNode: _passwordFocusNode,
                              isPasswordField: true,
                              textInputAction: TextInputAction.next,
                            ),
                            CustomInput(
                              controller: nameController,
                              hintText: "Name...",
                              onChanged: (value) {
                                _registerName = value;
                              },
                              focusNode: _nameFocusNode,
                              textInputAction: TextInputAction.next,
                            ),
                            CustomInput(
                              controller: phoneController,
                              hintText: "Phone...",
                              onChanged: (value) {
                                _registerPhone = value;
                              },
                              focusNode: _phoneFocusNode,
                              textInputType: TextInputType.number,
                            ),
                            state.isSubmitting
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomBtn(
                                    text: "Create New Account",
                                    onPressed: () async {
                                      if (isRegisterButtonEnabled(state)) {
                                        BlocProvider.of<RegisterBloc>(context)
                                            .add(
                                          RegisterEventPressed(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                              name: nameController.text),
                                        );
                                      }
                                    },
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
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
    ));
  }
}
