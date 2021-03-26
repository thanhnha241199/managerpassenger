// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:convert';
//
// import 'package:http/http.dart';
//
// TourBus tourBusFromJson(String str) => TourBus.fromJson(json.decode(str));
//
// String tourBusToJson(TourBus data) => json.encode(data.toJson());
//
// class TourBus {
//   TourBus({
//     this.id,
//     this.locationstart,
//     this.locationend,
//     this.time,
//     this.range,
//     this.price,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   String id;
//   String locationstart;
//   String locationend;
//   String time;
//   String range;
//   String price;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory TourBus.fromJson(Map<String, dynamic> json) =>
//       TourBus(
//         id: json["_id"],
//         locationstart: json["locationstart"],
//         locationend: json["locationend"],
//         time: json["time"],
//         range: json["range"],
//         price: json["price"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//       );
//
//   Map<String, dynamic> toJson() =>
//       {
//         "_id": id,
//         "locationstart": locationstart,
//         "locationend": locationend,
//         "time": time,
//         "range": range,
//         "price": price,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }
//
// Post postFromJson(String str) => Post.fromJson(json.decode(str));
//
// String postToJson(Post data) => json.encode(data.toJson());
//
// class Post {
//   Post({
//     this.userId,
//     this.id,
//     this.title,
//     this.body,
//   });
//
//   int userId;
//   int id;
//   String title;
//   String body;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     userId: json["userId"],
//     id: json["id"],
//     title: json["title"],
//     body: json["body"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "id": id,
//     "title": title,
//     "body": body,
//   };
// }
//
// class UserList extends StatefulWidget {
//   @override
//   _UserListState createState() => _UserListState();
// }
//
// class _UserListState extends State<UserList> {
//   final String apiUrl = "https://managerpassenger.herokuapp.com/gettourbus";
//   Future<List<Post>> fetchPost() async {
//     final response =
//     await http.get('https://jsonplaceholder.typicode.com/posts');
//
//     if (response.statusCode == 200) {
//       // If the call to the server was successful, parse the JSON
//       List<Post> post = postFromJson(response.body);
//       return post;
//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
//   Future<List<TourBus>> fetchUsers() async {
//     var result = await http.get(apiUrl);
//     print(result.body);
//     Iterable l = json.decode(result.body);
//     List<TourBus> posts = List<TourBus>.from(l.map((model){
//       TourBus.fromJson(model);
//       print(TourBus.fromJson(model));
//     }).toList());
//     return posts;
//   }
//
//   List<TourBus> _list;
//   bool isloading;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     isloading= true;
//     // fetchUsers().then((tourbus) {
//     //   _list = tourbus;
//     //   isloading  = false;
//     // });
//     fetchPost().then((value) {
//       print(value.id);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: isloading ? Text("Loading") : Text("Fetch"),
//       ),
//       body: isloading ? Center(child: CircularProgressIndicator(),) : Container(
//         child: ListView.builder(
//           itemCount: _list == null ? 0 : _list.length,
//           itemBuilder: (context, index){
//             return Text("Aaaa");
//           },
//         ),
//       ),
//     );
//   }
// }