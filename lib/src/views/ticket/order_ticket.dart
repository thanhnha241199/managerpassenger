import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_payment.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/user_repository.dart';

import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTicket extends StatefulWidget {
  TourBus tourBus;
  String time;
  bool dumplex;
  String title;
  String seat;
  String address;
  String name;
  String phone;
  String email;
  String datestart;
  String dateback;
  final UserRepository userRepository;

  OrderTicket(
      {this.userRepository,
      this.tourBus,
      this.dumplex,
      this.time,
      this.title,
      this.address,
      this.seat,
      this.name,
      this.email,
      this.phone,
      this.dateback,
      this.datestart});

  @override
  _OrderTicketState createState() => _OrderTicketState();
}

class _OrderTicketState extends State<OrderTicket> {
  String name, email, phone;

  Future<void> getInfor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = widget.name.isEmpty ? preferences.getString('name') : widget.name;
      phone =
          widget.phone.isEmpty ? preferences.getString('phone') : widget.phone;
      email =
          widget.email.isEmpty ? preferences.getString('email') : widget.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfor();
    print(widget.dumplex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc, TicketState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Success(
                      title: "Order Successfull",
                      page: HomePage(
                        userRepository: widget.userRepository,
                      ))),
              (route) => false);
        }
        if (state is FailureState) {
          print("Order Failed");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(tr('ordertick')),
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('inforcus'),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          tr('name'),
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tr('phone'),
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          phone,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tr('email'),
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          email,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                decoration: BoxDecoration(color: Colors.green),
              ),
              widget.dumplex == true
                  ? Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('infor1chieu'),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                tr('tour'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('name'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.time} ${widget.datestart}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('locstart'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "${widget.title}: ${widget.address}",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('quantyseat'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('seatquan'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                widget.seat,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('total1chieu'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                            tr('infor2chieu'),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                tr('tour'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                " ${widget.tourBus.locationend} => ${widget.tourBus.locationstart}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('name'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.time} ${widget.dateback}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('locstart'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "${widget.title}: ${widget.address}",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('quantyseat'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('seatquan'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                widget.seat,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('total2chieu'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      tr('price1chieu'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      tr('price2chieu'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      tr('fee'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "0 VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      tr('payment'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('infor1chieu'),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                tr('tour'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.tourBus.locationstart} => ${widget.tourBus.locationend}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('name'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.time} ${widget.datestart}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('locstart'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "${widget.title}: ${widget.address}",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('quantyseat'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('seatquan'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                widget.seat,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                tr('total1chieu'),
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      tr('price1chieu'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      tr('fee'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "0 VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      tr('payment'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            // height: 174,
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
            child: DefaultButton(
              press: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return BottomSheetRadio();
                    });
              },
              text: tr('payment'),
            )),
      ),
    );
  }
}
