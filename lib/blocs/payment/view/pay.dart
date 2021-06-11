import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:managepassengercar/blocs/payment/bloc/payment_bloc.dart';
import 'package:managepassengercar/blocs/payment/model/card.dart';
import 'package:managepassengercar/blocs/payment/view/add_card.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/providers/service_stripe.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ExistingCardsPage extends StatefulWidget {
  List<Discount> discount;
  TourBus tourBus;
  String time;
  bool dumplex;
  String title;
  String seat;
  String uid;
  String address;
  String name;
  String qr;
  String phone;
  String email;
  String datestart;
  String dateback;
  final UserRepository userRepository;

  ExistingCardsPage(
      {this.userRepository,
      this.tourBus,
      this.dumplex,
      this.time,
      this.title,
      this.address,
      this.uid,
      this.qr,
      this.seat,
      this.name,
      this.email,
      this.phone,
      this.dateback,
      this.datestart,
      this.discount});

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  String name, email, phone, id;

  payViaExistingCard(BuildContext context, CardModel card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = card.expiryDate.split('/');
    CreditCard stripeCard = CreditCard(
      number: card.cardNumber,
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: '2500', currency: 'USD', card: stripeCard);
    await dialog.hide();
    if (response.success == true) {
      BlocProvider.of<PaymentBloc>(context).add(OrderEvent(
          idtour: widget.tourBus.id,
          email: widget.email,
          name: widget.name,
          phone: widget.phone,
          qr: widget.qr,
          locationstart: widget.address,
          quantyseat: widget.seat.trim().split(' ').length.toString(),
          seat: widget.seat.trim(),
          time: widget.time,
          price: widget.tourBus.price,
          totalprice:
              "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
          uid: widget.uid));
      SharedPreferences pref = await SharedPreferences.getInstance();
      BlocProvider.of<PaymentBloc>(context).add(AddNoti(
          title: pref.getString("orderID"),
          description: "Đặt vé thành công!",
          id: widget.uid));
      String token = await FirebaseMessaging.instance.getToken();
      BlocProvider.of<PaymentBloc>(context).add(SendNoti(
          title: "Đặt vé thành công!",
          body: "Đơn hàng ${pref.getString("orderID")} đã được tạo",
          token: token));
      BlocProvider.of<PaymentBloc>(context).add(SendMail(
          idtour: widget.tourBus.id,
          email: widget.email,
          name: widget.name,
          phone: widget.phone,
          locationstart: widget.address,
          quantyseat: widget.seat.trim().split(' ').length.toString(),
          seat: widget.seat.trim(),
          time: widget.time,
          price: widget.tourBus.price,
          orderID: pref.getString("orderID"),
          totalprice:
              "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND"));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(userRepository: widget.userRepository)),
          (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<PaymentBloc>(context).add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Choose card",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddCard()));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FailureState) {
            return Center(
              child: Text("Error"),
            );
          }
          if (state is SuccessState) {
            return state.card.length == 0
                ? Text("111")
                : Container(
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: state.card.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            payViaExistingCard(context, state.card[index]);
                          },
                          child: CreditCardWidget(
                              cardNumber: state.card[index].cardNumber,
                              expiryDate: state.card[index].expiryDate,
                              cardHolderName: state.card[index].cardHolderName,
                              cvvCode: state.card[index].cvvCode,
                              showBackView: false),
                        );
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
