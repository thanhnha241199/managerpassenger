import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/payment/view/choose_payment.dart';
import 'package:managepassengercar/blocs/payment/view/pay.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_payment.dart';
import 'package:managepassengercar/blocs/ticket/view/voucher.dart';
import 'package:managepassengercar/providers/api_provider.dart';

import 'package:managepassengercar/repository/user_repository.dart';

import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/success.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTicket extends StatefulWidget {
  List<Discount> discount;
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
  int voucher;
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
      this.datestart,
      this.discount});

  @override
  _OrderTicketState createState() => _OrderTicketState();
}

class _OrderTicketState extends State<OrderTicket> {
  String name, email, phone;
  final formatter = new NumberFormat("#,###");
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
    widget.voucher = 0;
  }

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  GlobalKey globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    int sum1chieu = widget.seat.trim().split(' ').length *
        int.parse("${widget.tourBus.price}");
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                      ),
                      Row(
                        children: [
                          Text(
                            "QR",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Container(
                            child: Screenshot(
                              controller: screenshotController,
                              child: RepaintBoundary(
                                key: globalKey,
                                child: QrImage(
                                  data:
                                      "${widget.tourBus.id} ${widget.seat} ${widget.tourBus.locationstart}-${widget.tourBus.locationend}",
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                                        "${formatter.format(sum1chieu)} VND",
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
                                        "Giam gia",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(widget.voucher / 100) * int.parse("${widget.tourBus.price}")}",
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
                                  "${formatter.format(sum1chieu)} VND",
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
                                        "${formatter.format(sum1chieu)} VND",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Giam gia",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${formatter.format((widget.voucher / 100) * int.parse("${widget.tourBus.price}"))} VND",
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
                                        "${formatter.format(widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}") - (widget.voucher / 100) * int.parse("${widget.tourBus.price}"))} VND",
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
              vertical: (15),
              horizontal: (30),
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
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Voucher(
                                    discount: widget.discount,
                                  ))).then((value) {
                        setState(() {
                          widget.voucher = int.parse(value.toString());
                          print(widget.voucher);
                        });
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: (40),
                          width: (40),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.card_giftcard_outlined),
                        ),
                        Spacer(),
                        Text("Add voucher code"),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: (20)),
                  DefaultButton(
                    press: () {
                      screenshotController
                          .capture(delay: Duration(milliseconds: 10))
                          .then((Uint8List image) async {
                        Reference firebaseStorageRef =
                            FirebaseStorage.instance.ref().child('images/');
                        UploadTask uploadTask =
                            firebaseStorageRef.putData(image);
                        TaskSnapshot taskSnapshot = await uploadTask;
                        taskSnapshot.ref.getDownloadURL().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChoosePayment(
                                        tourBus: widget.tourBus,
                                        discount: widget.discount,
                                        dumplex: widget.dumplex,
                                        time: widget.time,
                                        title: widget.title,
                                        qr: value,
                                        email: widget.name,
                                        phone: widget.phone,
                                        name: widget.email,
                                        dateback: widget.dateback,
                                        datestart: widget.datestart,
                                        address: "address",
                                        seat: widget.seat,
                                      )));
                        });
                        print("File Saved to Gallery");
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                    text: tr('payment'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
