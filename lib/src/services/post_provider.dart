import 'package:dio/dio.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/services/api_request.dart';
class PostsProvider {
  void getPostsList({
    Function() beforeSend,
    Function(List<Schedule> posts) onSuccess,
    Function(dynamic error) onError,
  }) {
    ApiRequest(url: 'https://managerpassenger.herokuapp.com/getschedule', data: {"idtour": "6035d86551e0f5491c1d5cfc",} ).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        print("Data ${data}");
        onSuccess((data as List).map((postJson) => Schedule.fromJson(postJson)).toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}