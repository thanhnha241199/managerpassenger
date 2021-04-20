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
  String address;
  String name;
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
    BlocProvider.of<PaymentBloc>(context).add(OrderEvent(
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
            "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
        uid: id));
    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 3200),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
    });
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
