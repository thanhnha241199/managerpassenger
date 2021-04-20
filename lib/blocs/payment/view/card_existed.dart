import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:managepassengercar/blocs/payment/bloc/payment_bloc.dart';
import 'package:managepassengercar/blocs/payment/view/add_card.dart';
import 'package:managepassengercar/blocs/payment/view/pay.dart';

class CardExisted extends StatefulWidget {
  CardExisted({Key key}) : super(key: key);

  @override
  CardExistedState createState() => CardExistedState();
}

class CardExistedState extends State<CardExisted> {
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
                ? Text("Not add card")
                : Container(
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.card.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              headerAnimationLoop: true,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Thông báo',
                              desc: 'Bạn có chắc rằng muốn xoá ?',
                              buttonsTextStyle: TextStyle(color: Colors.black),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                BlocProvider.of<PaymentBloc>(context)
                                    .add(DeleteEvent(id: state.card[index].id));
                              },
                            )..show();
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
