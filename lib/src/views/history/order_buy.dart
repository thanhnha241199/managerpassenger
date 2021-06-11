import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/history/detail_order.dart';
import 'package:managepassengercar/src/views/history/ticket_view.dart';
import 'package:managepassengercar/utils/app_style.dart';

class OrderBuy extends StatefulWidget {
  List<Order> order;
  final UserRepository userRepository;
  OrderBuy({this.order, @required this.userRepository});
  @override
  _OrderBuyState createState() => _OrderBuyState();
}

class _OrderBuyState extends State<OrderBuy>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final f = new DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('danhsachve'),
          style: AppTextStyles.textSize16(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.blue,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: tr('lichsuve'),
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: tr('vedasudung'),
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.order
                          .where((element) => element.status == "order")
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        return TicketView(
                          order: widget.order
                              .where((element) => element.status == "order")
                              .toList()[index],
                          userRepository: widget.userRepository,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.order
                          .where((element) => element.status != "order")
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        return TicketView(
                          order: widget.order
                              .where((element) => element.status != "order")
                              .toList()[index],
                          userRepository: widget.userRepository,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
