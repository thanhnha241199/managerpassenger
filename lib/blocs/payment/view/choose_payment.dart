import 'dart:convert';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/payment/view/pay.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/providers/service_stripe.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePayment extends StatefulWidget {
  List<Discount> discount;
  TourBus tourBus;
  String time;
  String totlalPrice;
  bool dumplex;
  String title;
  String seat;
  String qr;
  String address;
  String name;
  String phone;
  String email;
  String datestart;
  String dateback;
  final UserRepository userRepository;

  ChoosePayment(
      {this.userRepository,
      this.tourBus,
      this.dumplex,
      this.time,
      this.title,
      this.address,
      this.totlalPrice,
      this.seat,
      this.qr,
      this.name,
      this.email,
      this.phone,
      this.dateback,
      this.datestart,
      this.discount});

  @override
  _ChoosePaymentState createState() => _ChoosePaymentState();
}

class _ChoosePaymentState extends State<ChoosePayment> {
  String name, email, phone, id;

  Future<void> getInfor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = widget.name.isEmpty ? preferences.getString('name') : widget.name;
      phone =
          widget.phone.isEmpty ? preferences.getString('phone') : widget.phone;
      email =
          widget.email.isEmpty ? preferences.getString('email') : widget.email;
      id = preferences.getString('id');
    });
  }

  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExistingCardsPage(
                      userRepository: widget.userRepository,
                      tourBus: widget.tourBus,
                      discount: widget.discount,
                      dumplex: widget.dumplex,
                      time: widget.time,
                      title: widget.title,
                      email: email,
                      phone: phone,
                      qr: widget.qr,
                      uid: id,
                      name: name,
                      dateback: widget.dateback,
                      datestart: widget.datestart,
                      address: widget.address,
                      seat: widget.seat,
                    )));
        break;
      case 2:
        payViaNoCard(context);
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    await dialog.hide();
    if (response.success == true) {
      BlocProvider.of<TicketBloc>(context).add(OrderEvent(
          idtour: widget.tourBus.id,
          email: email,
          name: name,
          phone: phone,
          qr: widget.qr,
          paymentType: "Card",
          locationstart: widget.address,
          quantyseat: widget.seat.trim().split(' ').length.toString(),
          seat: widget.seat.trim(),
          time: widget.time,
          price: widget.tourBus.price,
          totalprice:
              "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
          uid: id));
      SharedPreferences pref = await SharedPreferences.getInstance();
      BlocProvider.of<TicketBloc>(context).add(AddNoti(
          title: pref.getString("orderID"),
          description: "Đặt vé thành công!",
          id: id));
      String token = await FirebaseMessaging.instance.getToken();
      BlocProvider.of<TicketBloc>(context).add(SendNoti(
          title: "Đặt vé thành công!",
          body: "Đơn hàng ${pref.getString("orderID")} đã được tạo",
          token: token));
      BlocProvider.of<TicketBloc>(context).add(SendMail(
          idtour: widget.tourBus.id,
          email: email,
          name: name,
          phone: phone,
          locationstart: widget.address,
          quantyseat: widget.seat.trim().split(' ').length.toString(),
          seat: widget.seat.trim(),
          time: widget.time,
          price: widget.tourBus.price,
          totalprice:
              "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND"));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(userRepository: widget.userRepository)),
          (route) => false);
    } else {
      print("failed");
    }
  }

  payViaNoCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    BlocProvider.of<TicketBloc>(context).add(OrderEvent(
        idtour: widget.tourBus.id,
        email: email,
        name: name,
        phone: phone,
        qr: widget.qr,
        paymentType: "No Payment",
        locationstart: widget.address,
        quantyseat: widget.seat.trim().split(' ').length.toString(),
        seat: widget.seat.trim(),
        time: widget.time,
        price: widget.tourBus.price,
        totalprice:
            "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
        uid: id));
    SharedPreferences pref = await SharedPreferences.getInstance();
    BlocProvider.of<TicketBloc>(context).add(AddNoti(
        title: pref.getString("orderID"),
        description: "Đặt vé thành công!",
        id: id));
    String token = await FirebaseMessaging.instance.getToken();
    BlocProvider.of<TicketBloc>(context).add(SendNoti(
        title: "Đặt vé thành công!",
        body: "Đơn hàng ${pref.getString("orderID")} đã được tạo",
        token: token));
    BlocProvider.of<TicketBloc>(context).add(SendMail(
        idtour: widget.tourBus.id,
        email: email,
        name: name,
        phone: phone,
        locationstart: widget.address,
        quantyseat: widget.seat.trim().split(' ').length.toString(),
        seat: widget.seat.trim(),
        time: widget.time,
        orderID: pref.getString("orderID"),
        price: widget.tourBus.price,
        totalprice:
            "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND"));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage(userRepository: widget.userRepository)),
        (route) => false);
    await dialog.hide();
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
    getInfor();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            tr("Choose Payment"),
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          brightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.dark
              : Brightness.light,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
          ),
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr('totalpayment'),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Text(
                          widget.totlalPrice,
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        // Text(
                        //   "Premium Plan",
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontFamily: 'Raleway'),
                        // )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        Icon icon;
                        Text text;
                        switch (index) {
                          case 0:
                            icon = Icon(
                              Icons.add_circle,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 30,
                            );
                            text = Text(
                              tr('Pay via new card'),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Raleway'),
                            );
                            break;
                          case 1:
                            icon = Icon(Icons.credit_card,
                                size: 30,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black);
                            text = Text(
                              tr('Pay via existing card'),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Raleway'),
                            );
                            break;

                          case 2:
                            icon = Icon(Icons.credit_card,
                                size: 30,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black);
                            text = Text(
                              tr('payafter'),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Raleway'),
                            );
                            break;
                        }

                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () {
                              onItemPress(context, index);
                            },
                            child: ListTile(
                              title: text,
                              leading: icon,
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 3),
                ),
              ]),
        ));
  }
}
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _paymentResultCodeCode = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   _onBuyCoinPressed() async {
//     String paymentResultCodeCode;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       String url = 'http://sandbox.vnpayment.vn/paymentv2/vpcpay.html';
//       String tmnCode = 'XXX'; // Get from VNPay
//       String hashKey = 'XXX'; // Get from VNPay
//
//       final params = <String, dynamic>{
//         'vnp_Command': 'pay',
//         'vnp_Amount': '3000000',
//         'vnp_CreateDate': '20210315151908',
//         'vnp_CurrCode': 'VND',
//         'vnp_IpAddr': '192.168.15.102',
//         'vnp_Locale': 'vn',
//         'vnp_OrderInfo': '5fa66b8b5f376a000417e501 pay coin 30000 VND',
//         'vnp_ReturnUrl':
//             'XXX', // Your Server https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
//         'vnp_TmnCode': tmnCode,
//         'vnp_TxnRef': DateTime.now().millisecondsSinceEpoch.toString(),
//         'vnp_Version': '2.0.0'
//       };
//
//       final sortedParams = FlutterHlVnpay.instance.sortParams(params);
//       final hashDataBuffer = new StringBuffer();
//       sortedParams.forEach((key, value) {
//         hashDataBuffer.write(key);
//         hashDataBuffer.write('=');
//         hashDataBuffer.write(value);
//         hashDataBuffer.write('&');
//       });
//       final hashData =
//           hashDataBuffer.toString().substring(0, hashDataBuffer.length - 1);
//       final query = Uri(queryParameters: sortedParams).query;
//       print('hashData = $hashData');
//       print('query = $query');
//
//       var bytes = utf8.encode(hashKey + hashData.toString());
//       final vnpSecureHash = sha256.convert(bytes);
//       final paymentUrl =
//           "$url?$query&vnp_SecureHashType=SHA256&vnp_SecureHash=$vnpSecureHash";
//       print('paymentUrl = $paymentUrl');
//       paymentResultCodeCode = (await FlutterHlVnpay.instance.show(
//               paymentUrl: paymentUrl, tmnCode: tmnCode, scheme: 'hlsolutions'))
//           .toString();
//     } on PlatformException {
//       paymentResultCodeCode = 'Failed to get payment result code';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _paymentResultCodeCode = paymentResultCodeCode;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Text('Result Code: $_paymentResultCodeCode\n'),
//               RaisedButton(
//                 onPressed: this._onBuyCoinPressed,
//                 child: Text('10.000 VND'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
