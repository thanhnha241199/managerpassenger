import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/blocs/ticket/view/buy_ticket.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/utils/app_style.dart';

class DetailOrder extends StatefulWidget {
  final UserRepository userRepository;
  Order order;
  DetailOrder({this.order, @required this.userRepository});
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
          "Chi tiết hóa đơn",
          style: AppTextStyles.textSize16(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                      "Thông tin khách hàng",
                      style:
                          AppTextStyles.textSize20(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "Họ và tên",
                          style: AppTextStyles.textSize16(),
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
                          "Số điện thoại",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.phone,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.email,
                          style: AppTextStyles.textSize16(),
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
                      "Thông tin vé",
                      style: AppTextStyles.textSize20(),
                    ),
                    Row(
                      children: [
                        Text(
                          "ID",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.id,
                          style: AppTextStyles.textSize16(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tuyến",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          "${tourBus.locationstart}-${tourBus.locationend}",
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Thời gian",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.timetour,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Phương thức thanh toán",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.paymentType,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Địa điểm",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.location,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "QR",
                          style: AppTextStyles.textSize16(),
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
                          "Trạng thái",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.status,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Vị trí ghế",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.seat,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Số lượng",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.quantity,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tổng cộng",
                          style: AppTextStyles.textSize16(),
                        ),
                        Spacer(),
                        Text(
                          widget.order.totalprice,
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: AnimatedButton(
                  pressEvent: () {
                    BlocProvider.of<TicketBloc>(context).add(
                        ChangeOrder(id: widget.order.id, status: "complete"));
                    Navigator.pop(context);
                    BlocProvider.of<TicketBloc>(context).add(DoFetchEvent());
                    print(tourBus.id);
                  },
                  text: "Thanh toán",
                ),
              )
            ]);
          }
          return Container();
        },
      ),
    );
  }
}

class Review extends StatefulWidget {
  final String id;
  final String orderid;
  final UserRepository userRepository;
  Review({this.id, this.orderid, @required this.userRepository});
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController descriptionController = new TextEditingController();
  var ratingtour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                "Rating",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              )),
          SizedBox(
            height: 5.0,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: RatingBar.builder(
              itemSize: 30,
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                setState(() {
                  ratingtour = rating.toString();
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Add Review",
                border: InputBorder.none,
              ),
              maxLines: 8,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AnimatedButton(
              pressEvent: () {
                BlocProvider.of<TicketBloc>(context).add(ReviewTourbus(
                    id: widget.id,
                    rating: ratingtour,
                    description: descriptionController.text));
                BlocProvider.of<TicketBloc>(context)
                    .add(ChangeOrder(id: widget.orderid, status: "complete"));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(userRepository: widget.userRepository)));
              },
              text: "Review",
            ),
          ),
        ],
      ),
    );
  }
}
