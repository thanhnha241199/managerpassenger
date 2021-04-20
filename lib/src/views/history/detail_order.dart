import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/providers/api_provider.dart';

class DetailOrder extends StatefulWidget {
  Order order;
  DetailOrder({this.order});
  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TicketBloc>(context).add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiet hoa don",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessState) {
            int index = state.buyticket
                .indexWhere((element) => element.id == widget.order.tour);
            TourBus tourBus = state.buyticket[index];
            return Column(children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thong tin khach hang",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    Row(
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Phone",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.phone,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.email,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thong tin ve",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    Row(
                      children: [
                        Text(
                          "ID",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.id,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tuyen",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          "${tourBus.locationstart}-${tourBus.locationend}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.timetour,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.location,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "QR",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Container(
                                    child: Image.network(
                                      widget.order.qr,
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                                });
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Image.network(widget.order.qr)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Seat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.seat,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.quantity,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        Spacer(),
                        Text(
                          widget.order.totalprice,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        )
                      ],
                    )
                  ],
                ),
              ),
              AnimatedButton(
                pressEvent: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          content: Container(
                            width: 300.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800),
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: RatingBar.builder(
                                    itemSize: 30,
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Add Review",
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 8,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: AnimatedButton(
                                    pressEvent: () {},
                                    text: "Review",
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                text: "Danh gia",
              )
            ]);
          }
        },
      ),
    );
  }
}
