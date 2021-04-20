import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_ticket.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_tour.dart';
import 'package:managepassengercar/providers/api_provider.dart';
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
  bool swap;
  bool ontap = false;
  bool _switchValue = true;
  int number;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateReturn = DateTime.now();
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;
  ScrollController _scrollController = new ScrollController();
  List<Order> order;
  int present = 6;
  int perPage = 6;

  var originalItems = List<TourBus>();
  var items = List<TourBus>();

  void loadMore() async {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {
      if ((present + perPage) > originalItems.length) {
        items.addAll(originalItems.getRange(present, originalItems.length));
        print("1");
      } else {
        items.addAll(originalItems.getRange(present, present + perPage));
        present = present + perPage;
      }
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        loadMore();
      }
    }
    return false;
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
    super.dispose();
    _arrowAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    print(size / 5);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(
            'buyticket',
          ),
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderBuy(
                            order: order,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  EvaIcons.fileTextOutline,
                  color: Colors.white54,
                ),
                Text(
                  tr('rentalorder'),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
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
        buildWhen: (previous, current) {
          if (previous is SuccessState) {
            return false;
          } else {
            return true;
          }
        },
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
            order = state.order;
            originalItems = state.buyticket;
            items.addAll(originalItems.getRange(0, present));
            List<TourBus> choosesale = state.buyticket
                .where((element) => int.parse(element.sale) > 0)
                .toList();
            widget.locationstart = state.buyticket[0].locationstart;
            widget.locationend = state.buyticket[0].locationend;
            return Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue[400], Colors.blue[900]])),
                    height: MediaQuery.of(context).size.height * 0.2),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size / 7, left: 20.0, right: 20.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
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
                                      ? GestureDetector(
                                          onTap: () {
                                            Set temp = new Set();
                                            originalItems.forEach((element) {
                                              temp.add(element.locationstart);
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChooseTour(
                                                          choose: temp,
                                                        ))).then((value) {
                                              setState(() {
                                                widget.locationstart = value;
                                                widget.locationend =
                                                    "Choose tour";
                                              });
                                            });
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              Set temp = new Set();
                                              originalItems.forEach((element) {
                                                temp.add(element.locationstart);
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChooseTour(
                                                            choose: temp,
                                                          ))).then((value) {
                                                setState(() {
                                                  widget.locationstart = value;
                                                  widget.locationend =
                                                      "Choose tour";
                                                });
                                              });
                                            },
                                            child: Text(
                                                state.buyticket[number]
                                                    .locationstart,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                              state.buyticket[number]
                                                  .locationend,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
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
                                      ? GestureDetector(
                                          onTap: () {
                                            Set temp = new Set();
                                            originalItems.forEach((element) {
                                              temp.add(element.locationstart);
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChooseTour(
                                                          choose: temp,
                                                        ))).then((value) {
                                              setState(() {
                                                widget.locationstart = value;
                                                widget.locationend =
                                                    "Choose tour";
                                              });
                                            });
                                          },
                                          child: Text(
                                            state.buyticket[number].locationend,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Set temp = new Set();
                                            originalItems.forEach((element) {
                                              temp.add(element.locationstart);
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChooseTour(
                                                          choose: temp,
                                                        ))).then((value) {
                                              setState(() {
                                                widget.locationstart = value;
                                                widget.locationend =
                                                    "Choose tour";
                                              });
                                            });
                                          },
                                          child: Text(
                                            state.buyticket[number]
                                                .locationstart,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                          "${DateFormat('EEEE, d MMM, yyyy').format(selectedDate)}",
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
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            "${DateFormat('EEEE, d MMM, yyyy').format(selectedDateReturn)}",
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
                                              discount: state.discount,
                                              datestart:
                                                  selectedDate.toString(),
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
                ),
                _switchValue
                    ? Container(
                        padding: EdgeInsets.only(
                            top: ontap ? size / 1.45 : size / 1.7,
                            right: 20,
                            left: 20),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: _onScrollNotification,
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(top: 0),
                            itemCount: (present <= originalItems.length)
                                ? items.length + 1
                                : items.length,
                            itemBuilder:
                                (BuildContext buildContext, int index) {
                              return (index == items.length)
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : AnimatedContainer(
                                      duration: const Duration(seconds: 0),
                                      curve: Curves.fastOutSlowIn,
                                      decoration: BoxDecoration(
                                          color: index % 2 == 0
                                              ? Colors.blue.withOpacity(0.2)
                                              : Colors.red.withOpacity(0.2),
                                          border: Border.all(
                                              color: index == number
                                                  ? Colors.blue
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: ListTile(
                                        onTap: () {
                                          setState(() {
                                            widget.locationstart = state
                                                .buyticket[index].locationstart;
                                            widget.locationend = state
                                                .buyticket[index].locationend;
                                            number = index;
                                          });
                                        },
                                        // selected: index == number ? true : false,
                                        title: Row(
                                          children: [
                                            Text(
                                              "${items[index].locationstart}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway'),
                                            ),
                                            int.parse(state.buyticket[index]
                                                        .sale) >
                                                    0
                                                ? Text(
                                                    "${" - " + items[index].sale + "%"}")
                                                : Text(""),
                                            Spacer(),
                                            Icon(
                                              EvaIcons.arrowForwardOutline,
                                            ),
                                            Spacer(),
                                            Text(
                                              "${items[index].locationend}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway'),
                                            )
                                          ],
                                        ),
                                        subtitle: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              items[index].range,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              items[index].time,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              items[index].price,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                widget.id =
                                                    state.buyticket[index].id;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChedulesBus(
                                                              id: widget.id)));
                                            },
                                            child: Icon(EvaIcons
                                                .arrowCircleRightOutline)),
                                      ),
                                    );
                            },
                          ),
                        ))
                    : Container(
                        padding: EdgeInsets.only(
                            top: ontap ? 470 : 410, right: 20, left: 20),
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 0),
                          itemCount: choosesale.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return AnimatedContainer(
                              duration: const Duration(seconds: 0),
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  border: Border.all(
                                      color: index == number
                                          ? Colors.blue
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    widget.locationstart =
                                        choosesale[index].locationstart;
                                    widget.locationend =
                                        choosesale[index].locationend;
                                    number = index;
                                  });
                                },
                                // selected: index == number ? true : false,
                                title: Row(
                                  children: [
                                    Text(
                                      "${choosesale[index].locationstart}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Raleway'),
                                    ),
                                    int.parse(choosesale[index].sale) > 0
                                        ? Text(
                                            "${" - " + choosesale[index].sale + "%"}")
                                        : Text(""),
                                    Spacer(),
                                    Icon(
                                      EvaIcons.arrowForwardOutline,
                                    ),
                                    Spacer(),
                                    Text(
                                      "${choosesale[index].locationend}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Raleway'),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      choosesale[index].range,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      choosesale[index].time,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      choosesale[index].price,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                trailing: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.id = choosesale[index].id;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChedulesBus(id: widget.id)));
                                    },
                                    child:
                                        Icon(EvaIcons.arrowCircleRightOutline)),
                              ),
                            );
                          },
                        )),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

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
}
