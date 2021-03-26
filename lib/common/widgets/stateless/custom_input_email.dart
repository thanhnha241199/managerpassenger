import 'package:flutter/material.dart';
import 'package:managepassengercar/src/utils/constants.dart';

class CustomInputEmail extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final TextInputType textInputType;
  TextEditingController controller = TextEditingController();

  CustomInputEmail(
      {this.hintText,
      this.onChanged,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField,
      this.textInputType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      height: MediaQuery.of(context).size.height / 12,
      width: MediaQuery.of(context).size.width / 1.2,
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        validator: (_){
          return null;
        },
        textInputAction: textInputAction,
        decoration: InputDecoration(
            hintMaxLines: 10,
            border: InputBorder.none,
            hintText: hintText ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
