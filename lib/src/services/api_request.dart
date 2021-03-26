import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRequest {
  final String url;
  final Map data;

  ApiRequest({
    @required this.url,
    this.data,
  });

  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(headers: {
      'Authorization': 'B ....',
    }));
  }

  void get({
    Function() beforeSend,
    Function(dynamic data) onSuccess,
    Function(dynamic error) onError,
  }) {
    _dio().get(this.url, queryParameters: this.data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}
class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}