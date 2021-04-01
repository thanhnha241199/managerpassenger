import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/payment/view/pay.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/providers/service_stripe.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetRadio extends StatefulWidget {
  @override
  _BottomSheetRadio createState() => _BottomSheetRadio();
}

class _BottomSheetRadio extends State<BottomSheetRadio> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 40.0,
                height: 5.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        tr('option'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            payViaNewCard(context);
                          },
                          leading:
                              Icon(Icons.add_circle, color: theme.primaryColor),
                          title: Text('Pay via new card'),
                        ),
                        ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExistingCardsPage()));
                            },
                            leading: Icon(Icons.credit_card,
                                color: theme.primaryColor),
                            title: Text('Pay via existing card')),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    await dialog.hide();
    SharedPreferences pref = await SharedPreferences.getInstance();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userRepository: null),
        ),
        (route) => false);
    // BlocProvider.of<TicketBloc>(context).add(OrderEvent(
    //     idtour: widget.tourBus.id,
    //     email: email,
    //     name: name,
    //     phone: phone,
    //     locationstart: widget.address,
    //     quantyseat: widget.seat.trim().split(' ').length.toString(),
    //     seat: widget.seat.trim(),
    //     time: widget.time,
    //     price: widget.tourBus.price,
    //     totalprice:
    //         "${widget.seat.trim().split(' ').length * int.parse("${widget.tourBus.price}")} VND",
    //     uid: pref.getString('id')));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }
}
