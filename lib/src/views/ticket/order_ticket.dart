import 'package:flutter/material.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';

class OrderTicket extends StatefulWidget {
  final UserRepository userRepository;

  OrderTicket({this.userRepository});

  @override
  _OrderTicketState createState() => _OrderTicketState();
}

class _OrderTicketState extends State<OrderTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Order Ticket"),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thong tin khach hang",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text("Ho va ten"),
                    Spacer(),
                    Text("Huynh thanh nha"),
                  ],
                ),
                Row(
                  children: [
                    Text("SDT"),
                    Spacer(),
                    Text("H1234567890"),
                  ],
                ),
                Row(
                  children: [
                    Text("Email"),
                    Spacer(),
                    Text("nha@gmail.com"),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(color: Colors.green),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thong tin luot di",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text("Tuyen xe"),
                    Spacer(),
                    Text("BX Mien Dong => Ninh Hoa"),
                  ],
                ),
                Row(
                  children: [
                    Text("Thoi gian"),
                    Spacer(),
                    Text("21:00 01/01/2020"),
                  ],
                ),
                Row(
                  children: [
                    Text("Diem len xe"),
                    Spacer(),
                    Column(
                      children: [
                        Text("Suoi linh"),
                        Text("VP suoi linh: 123 tran van hoia.....")
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("So luong ghe"),
                    Spacer(),
                    Text("2"),
                  ],
                ),
                Row(
                  children: [
                    Text("So ghe"),
                    Spacer(),
                    Text("A12, A13"),
                  ],
                ),
                Row(
                  children: [
                    Text("Tong tien luot di"),
                    Spacer(),
                    Text("350.000d"),
                  ],
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Gia ve luot di"),
                          Spacer(),
                          Text("350.000d"),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Phi thanh toan"),
                          Spacer(),
                          Text("0d"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Thanh toan"),
                          Spacer(),
                          Text("350.000d"),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: DefaultButton(
                    press: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Success(
                                  title: "Sign Up Successfull",
                                  page: HomePage(
                                    userRepository: widget.userRepository,
                                  ))),
                          (route) => false);
                    },
                    text: "Thanh toan",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
