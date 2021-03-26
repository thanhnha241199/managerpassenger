import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/login/bloc/login_bloc.dart';
import 'package:managepassengercar/src/utils/constants.dart';

class CustomInputPassword extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  bool passwordVisible;
  LoginState loginState;
  final TextInputType textInputType;
  TextEditingController controller = TextEditingController();

  CustomInputPassword(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.passwordVisible,
      this.isPasswordField,
        this.loginState,
      this.textInputType,
      this.controller});

  @override
  _CustomInputPasswordState createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
  bool _isPasswordField;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isPasswordField = widget.isPasswordField ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      width: MediaQuery.of(context).size.width / 1.2,
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        autocorrect: true,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: !widget.passwordVisible,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
          validator: (_){
            // return widget.loginState ? null : 'Invalid password format';
          },
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.passwordVisible = !widget.passwordVisible;
                });
              },
              icon: Icon(
                widget.passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            border: InputBorder.none,
            hintText: widget.hintText ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
