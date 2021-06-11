import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/ticket/model/order.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_ticket.dart';
import 'package:managepassengercar/blocs/ticket/view/choose_tour.dart';
import 'package:managepassengercar/providers/api_provider.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/history/order_buy.dart';
import 'package:managepassengercar/src/views/ticket/chedules.dart';
import 'package:managepassengercar/src/views/widget/bottom_sheet.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';
import 'package:managepassengercar/src/views/widget/switch.dart';
import 'package:managepassengercar/utils/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Ticket extends StatefulWidget {
  String locationstart;
  String locationend;
  String id;
  final UserRepository userRepository;
  Ticket(
      {this.locationstart,
      this.locationend,
      this.id,
      @required this.userRepository});

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
  Set listStart = Set();
  Set listEnd = Set();
  AnimationController _arrowAnimationController;
  ScrollController _scrollController = new ScrollController();
  List<Order> order;
  int present = 6;
  int perPage = 6;

  var originalItems = List<TourBus>();
  var items = List<TourBus>();
  final format = new NumberFormat("#,###", "en_US");
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(
            'buyticket',
          ),
          style: AppTextStyles.textSize20(
              fontWeight: FontWeight.bold, color: Colors.white),
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
                            userRepository: widget.userRepository,
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
                Text(tr('rentalorder'),
                    style: AppTextStyles.textSize14(
                        color: Colors.white54, fontWeight: FontWeight.bold)),
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
            order = state.order;
            originalItems = state.buyticket;
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
                Column(
                  children: [
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
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      state.buyticket.forEach((element) {
                                        listStart.add(element.locationstart);
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChooseTour(
                                                  tour: listStart
                                                      .toList()))).then(
                                          (value) {
                                        setState(() {
                                          if (value != null) {
                                            number = state.buyticket.indexWhere(
                                                (element) =>
                                                    element.locationstart ==
                                                    value);
                                            print(number);
                                          } else {
                                            number = number;
                                          }
                                        });
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          tr('locationStart'),
                                        ),
                                        !swap
                                            ? Text(
                                                state.buyticket[number]
                                                    .locationstart,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                state.buyticket[number]
                                                    .locationend,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    ),
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
                                      builder: (context, child) =>
                                          Transform.rotate(
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
                                  GestureDetector(
                                    onTap: () {
                                      state.buyticket
                                          .where((e) =>
                                              e.locationstart ==
                                              state.buyticket[number]
                                                  .locationstart)
                                          .toList()
                                          .forEach((element) {
                                        listEnd.add(element.locationend);
                                      });
                                      print(listEnd);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChooseTour(
                                                  tour:
                                                      listEnd.toList()))).then(
                                          (value) {
                                        setState(() {
                                          if (value != null) {
                                            number = state.buyticket.indexWhere(
                                                (element) =>
                                                    element.locationend ==
                                                    value);
                                          } else {
                                            number = number;
                                          }
                                        });
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          tr('locationEnd'),
                                        ),
                                        !swap
                                            ? Text(
                                                state.buyticket[number]
                                                    .locationend,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Text(
                                                state.buyticket[number]
                                                    .locationstart,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          tr('timestart'),
                                          style: AppTextStyles.textSize18(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _selectDate(context);
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
                                              "${DateFormat('EEEE, d MMM, yyyy').format(selectedDate)}",
                                              style: AppTextStyles.textSize20(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          tr('2chieu'),
                                          style: AppTextStyles.textSize18(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                  press: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    if (pref.getString("token") == null) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.QUESTION,
                                        headerAnimationLoop: true,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Bạn chưa đăng nhập',
                                        desc:
                                            'Vui lòng đăng nhập để có thể tiếp tục sử dung!',
                                        buttonsTextStyle:
                                            TextStyle(color: Colors.black),
                                        btnCancelOnPress: () {},
                                        onDissmissCallback: () {
                                          debugPrint(
                                              'Dialog Dissmiss from callback');
                                        },
                                        btnOkOnPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage(
                                                          userRepository: widget
                                                              .userRepository)));
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("Cancel");
                                        },
                                      )..show();
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseTicket(
                                                    userRepository:
                                                        widget.userRepository,
                                                    discount: state.discount,
                                                    datestart:
                                                        selectedDate.toString(),
                                                    dateback: selectedDateReturn
                                                        .toString(),
                                                    tourBus:
                                                        state.buyticket[number],
                                                    dumplex: ontap,
                                                  ))).then((value) {
                                        // setState(() {
                                        //   ontap = value;
                                        // });
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              : Text(
                                                  tr('sale'),
                                                  style:
                                                      TextStyle(fontSize: 16),
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
                        ? Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              itemCount: state.buyticket.length,
                              itemBuilder:
                                  (BuildContext buildContext, int index) {
                                return AnimatedContainer(
                                  duration: Duration(seconds: 0),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.blue.withOpacity(0.5)
                                              : Colors.blue.withOpacity(0.2)
                                          : Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.red.withOpacity(0.5)
                                              : Colors.red.withOpacity(0.2),
                                      border: Border.all(
                                          color: index == number
                                              ? Colors.blue
                                              : Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        widget.locationstart = state
                                            .buyticket[index].locationstart;
                                        widget.locationend =
                                            state.buyticket[index].locationend;
                                        number = index;
                                      });
                                    },
                                    // selected: index == number ? true : false,
                                    title: Row(
                                      children: [
                                        Text(
                                          "${state.buyticket[index].locationstart}",
                                          style: AppTextStyles.textSize18(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        int.parse(state.buyticket[index].sale) >
                                                0
                                            ? Text(
                                                "${" - " + state.buyticket[index].sale + "%"}")
                                            : Text(""),
                                        Spacer(),
                                        Icon(
                                          EvaIcons.arrowForwardOutline,
                                        ),
                                        Spacer(),
                                        Text(
                                          "${state.buyticket[index].locationend}",
                                          style: AppTextStyles.textSize18(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
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
                                          state.buyticket[index].range,
                                          style: AppTextStyles.textSize14(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Spacer(),
                                        Text(
                                          state.buyticket[index].time,
                                          style: AppTextStyles.textSize14(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Spacer(),
                                        Text(
                                          format.format(int.parse(
                                              state.buyticket[index].price)),
                                          style: AppTextStyles.textSize14(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
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
                                        child: Icon(
                                            EvaIcons.arrowCircleRightOutline)),
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              itemCount: choosesale.length,
                              itemBuilder:
                                  (BuildContext buildContext, int index) {
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
                                        Expanded(
                                          child: Text(
                                            "${choosesale[index].locationstart}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway'),
                                          ),
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
                                        Expanded(
                                          child: Text(
                                            "${choosesale[index].locationend}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway'),
                                          ),
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
                                                      ChedulesBus(
                                                          id: widget.id)));
                                        },
                                        child: Icon(
                                            EvaIcons.arrowCircleRightOutline)),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                )
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
