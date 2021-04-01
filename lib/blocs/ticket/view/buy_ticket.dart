import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_ticket.dart';
import 'package:managepassengercar/src/views/history/order_buy.dart';
import 'package:managepassengercar/src/views/ticket/chedules.dart';
import 'package:managepassengercar/src/views/widget/bottom_sheet.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';

class Ticket extends StatefulWidget {
  String locationstart;
  String locationend;
  String id;

  Ticket({this.locationstart, this.locationend, this.id});

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> with TickerProviderStateMixin {
  int selectRadio;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateReturn = DateTime.now();
  bool swap;

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  _selectDateReturn(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePickerReturn(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TicketBloc>(context).add(DoFetchEvent());
    number = 0;
    swap = false;
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _arrowAnimation =
        Tween(begin: 0.0, end: 2 * pi).animate(_arrowAnimationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _arrowAnimationController?.dispose();
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: tr('"Selectbookingdate"'),
      cancelText: tr('cancel'),
      confirmText: tr('book'),
      errorFormatText: tr('Entervaliddate'),
      errorInvalidText: tr('Enterdateinvalidrange'),
      fieldLabelText: tr('Bookingdate'),
      fieldHintText: tr('Month/Date/Year'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  buildMaterialDatePickerReturn(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: tr('"Selectbookingdate"'),
      cancelText: tr('cancel'),
      confirmText: tr('book'),
      errorFormatText: tr('Entervaliddate'),
      errorInvalidText: tr('Enterdateinvalidrange'),
      fieldLabelText: tr('Bookingdate'),
      fieldHintText: tr('Month/Date/Year'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDateReturn = picked;
      });
  }

  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;
  bool ontap = false;
  bool _switchValue = true;
  int number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('buyticket'),
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OrderBuy()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(EvaIcons.fileTextOutline),
                Text(tr('rentalorder')),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FailureState) {
            return Scaffold(
              body: Center(
                child: Text(state.msg),
              ),
            );
          }
          if (state is SuccessState) {
            widget.locationstart = state.buyticket[0].locationstart;
            widget.locationend = state.buyticket[0].locationend;
            return Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomCenter,
                            colors: [Colors.red[900], Colors.blue[700]])),
                    height: MediaQuery.of(context).size.height * 0.2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 95.0, left: 20.0, right: 20.0),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tr('locationstart'),
                                  style: TextStyle(),
                                ),
                                swap == false
                                    ? Text(
                                        state.buyticket[number].locationstart,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                    : Text(state.buyticket[number].locationend,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  swap = !swap;
                                });
                                _arrowAnimationController.isCompleted
                                    ? _arrowAnimationController.reverse()
                                    : _arrowAnimationController.forward();
                              },
                              child: AnimatedBuilder(
                                animation: _arrowAnimationController,
                                builder: (context, child) => Transform.rotate(
                                  angle: _arrowAnimation.value,
                                  child: Icon(
                                    EvaIcons.syncOutline,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  tr('locationend'),
                                  style: TextStyle(),
                                ),
                                swap == false
                                    ? Text(
                                        state.buyticket[number].locationend,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        state.buyticket[number].locationstart,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    tr('timestart'),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    tr('2chieu'),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SwitchControl(
                                    onChanged: (value) {
                                      if (ontap == true) {
                                        setState(() {
                                          ontap = false;
                                        });
                                      } else {
                                        setState(() {
                                          ontap = true;
                                        });
                                      }
                                    },
                                    value: ontap,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ontap
                              ? Column(
                                  children: [
                                    Text(
                                      tr('timeend'),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _selectDateReturn(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 4),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          "${selectedDateReturn.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          DefaultButton(
                            text: tr('findtick'),
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseTicket(
                                            datestart: selectedDate.toString(),
                                            dateback:
                                                selectedDateReturn.toString(),
                                            tourBus: state.buyticket[number],
                                            dumplex: ontap,
                                          ))).then((value) {
                                setState(() {
                                  ontap = value;
                                });
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr('tickpopular'),
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BottomSheetRadio(
                                          switchValue: _switchValue,
                                          valueChanged: (value) {
                                            setState(() {
                                              _switchValue = value;
                                            });
                                          },
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    _switchValue
                                        ? Text(
                                            tr('all'),
                                            style: TextStyle(fontSize: 16),
                                          )
                                        : Text(
                                            tr('sale'),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: ontap ? 450 : 380, right: 20, left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext buildContext, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: index == number
                                      ? Colors.red
                                      : Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                widget.locationstart =
                                    state.buyticket[index].locationstart;
                                widget.locationend =
                                    state.buyticket[index].locationend;
                                number = index;
                                print(number);
                              });
                            },
                            selected: index == number ? true : false,
                            title: Row(
                              children: [
                                Text(state.buyticket[index].locationstart),
                                Spacer(),
                                Icon(EvaIcons.arrowForwardOutline),
                                Spacer(),
                                Text(state.buyticket[index].locationend)
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(state.buyticket[index].range),
                                Spacer(),
                                Text(
                                  state.buyticket[index].time,
                                ),
                                Spacer(),
                                Text(state.buyticket[index].price)
                              ],
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.id = state.buyticket[index].id;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChedulesBus(id: widget.id)));
                                },
                                child: Icon(EvaIcons.arrowCircleRightOutline)),
                          ),
                        );
                      },
                      itemCount: state.buyticket.length,
                    )),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
