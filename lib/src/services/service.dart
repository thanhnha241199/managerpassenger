import 'package:dio/dio.dart';
import 'package:managepassengercar/src/models/schedule.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:http/http.dart' as http;

// class Service{
//    static Future<List<Schedule>> getSchedule() async{
//     try {
//       final response = await http.get(Constants.BASE_URL+'/gettourbus');
//       if (response != null && response.statusCode == 200) {
//         final List<Schedule> schedule = Schedule.fromJson(response.body) as List<Schedule>;
//         return schedule;
//       }else{
//         return Schedule();
//       }
//     } catch (e) {
//       print(e);
//       return Schedule();
//     }
//   }
// }