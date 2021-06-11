import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/models/tourbus.dart';
import 'package:managepassengercar/src/views/history/detail_order.dart';
import 'package:managepassengercar/utils/app_style.dart';
import 'package:shimmer/shimmer.dart';

class TicketView extends StatelessWidget {
  Order order;
  final UserRepository userRepository;
  TicketView({this.order, @required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 60.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 60.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
        if (state is SuccessState) {
          int index =
              state.buyticket.indexWhere((element) => element.id == order.tour);
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailOrder(
                              order: order,
                              userRepository: userRepository,
                            )));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              state.buyticket[index].locationstart,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.indigo.shade50,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                height: 8,
                                width: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo.shade400,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 24,
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Flex(
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        6)
                                                    .floor(),
                                                (index) => SizedBox(
                                                      height: 1,
                                                      width: 3,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                      ),
                                                    )),
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          );
                                        },
                                      ),
                                    ),
                                    Center(
                                        child: Transform.rotate(
                                      angle: 1.5,
                                      child: Icon(
                                        Icons.car_rental,
                                        color: Colors.indigo.shade300,
                                        size: 24,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade50,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                height: 8,
                                width: 8,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade400,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              state.buyticket[index].locationend,
                              style: AppTextStyles.textSize18(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                width: 100,
                                child: Text(
                                  state.buyticket[index].locationstart,
                                  style: AppTextStyles.textSize12(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.grey),
                                )),
                            Text(
                              order.timetour,
                              style: AppTextStyles.textSize14(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            SizedBox(
                                width: 100,
                                child: Text(
                                  state.buyticket[index].locationend,
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.textSize12(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.grey),
                                )),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              order.createdAt.toString(),
                              style: AppTextStyles.textSize12(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  tr('quantity'),
                                  style: AppTextStyles.textSize12(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                Text(
                                  order.quantity,
                                  style: AppTextStyles.textSize12(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.grey.shade200),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Flex(
                                  children: List.generate(
                                      (constraints.constrainWidth() / 10)
                                          .floor(),
                                      (index) => SizedBox(
                                            height: 1,
                                            width: 5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade400),
                                            ),
                                          )),
                                  direction: Axis.horizontal,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: Colors.grey.shade200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24))),
                    child: Row(
                      children: <Widget>[
                        // Container(
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //       color: Colors.amber.shade50,
                        //       borderRadius: BorderRadius.circular(20)),
                        //   child: Icon(Icons.flight_land, color: Colors.amber),
                        // ),
                        // SizedBox(
                        //   width: 16,
                        // ),
                        // Text("Jet Airways",
                        //     style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.grey)),
                        Expanded(
                            child: Text("${order.price} VND",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.textSize18(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.grey))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
