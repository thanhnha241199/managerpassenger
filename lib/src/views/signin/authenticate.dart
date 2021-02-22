import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthSevice{
  Dio dio = new Dio();
  login(name, password) async{
    try {
      return await dio.post("https://test9862.herokuapp.com/authenticate",
      data: {
        "name": name,
        "password": password
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch(e){
      Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16
      );
    }
  }
}