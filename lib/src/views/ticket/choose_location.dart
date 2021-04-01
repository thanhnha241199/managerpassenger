import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';

class BottomSheetLocation extends StatefulWidget {
  BottomSheetLocation(
      {@required this.switchValue, @required this.valueChanged, this.id});

  String id;
  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  _BottomSheetLocation createState() => _BottomSheetLocation();
}

class _BottomSheetLocation extends State<BottomSheetLocation> {
  bool _switchValue;

  int num;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TicketBloc>(context)
        .add(DoFetchEvent(idtourbus: widget.id));
    _switchValue = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: CircularProgressIndicator(),
              ));
          ;
        }
        if (state is FailureState) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Text(state.msg),
              ),
            ),
          );
        }
        if (state is SuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
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
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            tr('listlocation'),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.pickup[0].address.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      state.pickup[0].address[index].title),
                                  subtitle: Text(
                                      state.pickup[0].address[index].address),
                                  onTap: () {
                                    setState(() {
                                      num = index;
                                    });
                                    Navigator.pop(
                                        context,
                                        state.pickup[0].address[num].address +
                                            " , " +
                                            state.pickup[0].address[num].title);
                                  },
                                  selected: num == index ? true : false,
                                  trailing: num == index
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.redAccent,
                                        )
                                      : Text(""),
                                )
                              ],
                            ),
                          );
                        },
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
