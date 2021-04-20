import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';

class BottomSheetTime extends StatefulWidget {
  int time;
  final String id;
  String price;
  final bool switchValue;
  final ValueChanged valueChanged;

  BottomSheetTime(
      {@required this.switchValue,
      @required this.valueChanged,
      @required this.id,
      this.price,
      this.time});

  @override
  _BottomSheetTime createState() => _BottomSheetTime();
}

class _BottomSheetTime extends State<BottomSheetTime> {
  bool _switchValue;
  int number;
  final formatter = new NumberFormat("#,###");
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TicketBloc>(context)
        .add(DoFetchEvent(idtourbus: widget.id));
    _switchValue = widget.switchValue;
    number = widget.time;
  }

  int convertTime(String str) {
    String text = str.substring(0, 2).trim();
    int num = int.parse(text);
    return num;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      buildWhen: (previous, current) {
        if (previous is SuccessState) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is FailureState) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: Text(state.msg),
              ),
            ),
          );
        }
        if (state is SuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 50.0,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                tr('timesstart'),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: state.pickup[0].time.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: Colors.white),
                                        child: ListTile(
                                          leading: Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color: Colors.amberAccent,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Icon(Icons.alarm),
                                          ),
                                          title: Text(
                                            state.pickup[0].time[index]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          subtitle: Text(
                                            "${tr('seat')} -  ${formatter.format(int.parse(widget.price))} (VND)",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              number = index;
                                            });
                                            Navigator.pop(
                                                context,
                                                state.pickup[0].time[number]
                                                    .toString());
                                          },
                                          selected:
                                              number == index ? true : false,
                                          trailing: number == index
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Colors.redAccent,
                                                )
                                              : Text(""),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
