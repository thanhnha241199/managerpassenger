import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/rental/bloc/rental_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRental extends StatefulWidget {
  String id;
  OrderRental({this.id});
  @override
  _OrderRentalState createState() => _OrderRentalState();
}

class _OrderRentalState extends State<OrderRental>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    BlocProvider.of<RentalBloc>(context).add(DoFetchEventData(id: widget.id));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding2 = Padding(
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
                color: Colors.green,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Lich su ve',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Sap khoi hanh',
                ),
              ],
            ),
          ),
          // tab bar view here
          BlocBuilder<RentalBloc, RentalState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is FailureState) {
                return Center(
                  child: Text(state.msg),
                );
              }
              if (state is SuccessStateOrder) {
                return Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ListView.builder(
                          itemCount: state.rental.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20),
                                    child: Text(
                                      "Order ID: ${state.rental[index].id}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    title: Text("Detail"),
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start: ${state.rental[index].locationstart}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "End: ${state.rental[index].locationend}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("Note: ${state.rental[index].note}")
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // second tab bar view widget
                      Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order rental",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: padding2,
    );
  }
}
