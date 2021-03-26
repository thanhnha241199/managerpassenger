import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';

class ChoosePosition extends StatefulWidget {
  final String id;
  final String price;

  ChoosePosition({this.id, this.price});

  @override
  _ChoosePositionState createState() => _ChoosePositionState();
}

class _ChoosePositionState extends State<ChoosePosition> {
  int count = 0;
  String seat = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TicketBloc>(context)
        .add(DoFetchEvent(idtourbus: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Chon giuong ${count}/5"),
            centerTitle: true,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 0.0,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, seat);
                },
                icon: Icon(Icons.close),
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Icon(Icons.download_outlined), Text("Tang duoi")],
                )),
                Tab(
                    icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Icon(Icons.upgrade_outlined), Text("Tang tren")],
                )),
              ],
            ),
          ),
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
                return TabBarView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors1[0] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[0] =
                                                      "done";
                                                  seat += " A01";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A01")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[0] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[0] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A01", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A01")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A01")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[1] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[1] =
                                                      "done";
                                                  seat += " A02";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A02")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[1] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[1] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A02", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A02")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A02")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[2] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[2] =
                                                      "done";
                                                  seat += " A03";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A03")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[2] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[2] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A03", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A03")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A03")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors1[3] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[3] =
                                                      "done";
                                                  seat += " A04";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A04")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[3] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[3] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A04", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A04")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A04")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[4] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors1[4] =
                                                      "done";
                                                  seat += " A05";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A05")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[4] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[4] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A05", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A05")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A05")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[5] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[5] =
                                                      "done";
                                                  seat += " A06";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A06")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[5] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[5] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A06", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A06")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A06")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors1[6] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[6] =
                                                      "done";
                                                  seat += " A07";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A07")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[6] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[6] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A07", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A07")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A07")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[7] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors1[7] =
                                                      "done";
                                                  seat += " A08";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A08")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[7] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[7] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A08", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A08")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A08")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[8] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[8] =
                                                      "done";
                                                  seat += " A09";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A09")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[8] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[8] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A09", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A09")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A09")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors1[9] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[9] =
                                                      "done";
                                                  seat += " A10";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A10")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[9] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[9] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A10", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A10")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A10")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[10] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors1[10] =
                                                      "done";
                                                  seat += " A11";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A11")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[10] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[10] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A11", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A11")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A11")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[11] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[11] =
                                                      "done";
                                                  seat += " A12";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A12")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[11] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[11] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A12", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A12")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A12")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors1[12] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[12] =
                                                      "done";
                                                  seat += " A13";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A13")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[12] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[12] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A13", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A13")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A13")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[13] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors1[13] =
                                                      "done";
                                                  seat += " A14";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A14")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[13] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[13] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A14", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A14")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A14")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors1[14] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[14] =
                                                      "done";
                                                  seat += " A15";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A15")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[14] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[14] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A15", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A15")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A15")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                    ),
                                    state.seat[0].floors1[15] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors1[15] =
                                                      "done";
                                                  seat += " A16";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("A16")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors1[15] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[15] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "A16", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A16")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("A16")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      state.seat[0].floors1[16] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors1[16] =
                                                        "done";
                                                    seat += " A17";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("A17")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors1[16] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors1[16] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "A17", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A17")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A17")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors1[17] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors1[17] =
                                                        "done";
                                                    seat += " A18";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("A18")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors1[17] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors1[17] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "A18", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A18")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A18")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors1[18] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors1[18] =
                                                        "done";
                                                    seat += " A19";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("A19")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors1[18] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors1[18] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "A19", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A19")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A19")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors1[19] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors1[19] =
                                                        "done";
                                                    seat += " A20";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("A20")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors1[19] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors1[19] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "A20", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A20")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A20")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors1[20] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors1[20] =
                                                        "done";
                                                    seat += " A21";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("A21")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors1[20] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors1[20] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "A21", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A21")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("A21")
                                                    ],
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Ghế đã chọn"),
                                          Spacer(),
                                          Text(seat == null ? " " : seat)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Tổng tiền"),
                                          Spacer(),
                                          Text(
                                              "${count * int.parse(widget.price)} VND")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Trống")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.redAccent),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Đang chọn")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Đã đặt")
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: DefaultButton(
                                  press: () {
                                    Navigator.pop(context, seat);
                                  },
                                  text: "Tiep tuc",
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors2[0] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[0] =
                                                      "done";
                                                  seat += " B01";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B01")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[0] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[0] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B01", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B01")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B01")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[1] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[1] =
                                                      "done";
                                                  seat += " B02";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B02")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[1] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[1] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B02", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B02")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B02")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[2] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[2] =
                                                      "done";
                                                  seat += " B03";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B03")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[2] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[2] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B03", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B03")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B03")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors2[3] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[3] =
                                                      "done";
                                                  seat += " B04";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B04")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[3] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[3] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B04", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B04")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B04")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[4] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors2[4] =
                                                      "done";
                                                  seat += " B05";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B05")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[4] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[4] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B05", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B05")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B05")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[5] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[5] =
                                                      "done";
                                                  seat += " B06";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B06")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[5] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[5] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B06", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B06")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B06")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors2[6] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[6] =
                                                      "done";
                                                  seat += " B07";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B07")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[6] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[6] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B07", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B07")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B07")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[7] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors2[7] =
                                                      "done";
                                                  seat += " B08";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B08")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[7] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[7] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B08", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B08")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B08")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[8] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[8] =
                                                      "done";
                                                  seat += " B09";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B09")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[8] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[8] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B09", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B09")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B09")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors2[9] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[9] =
                                                      "done";
                                                  seat += " B10";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B10")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[9] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[9] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B10", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B10")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B10")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[10] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors2[10] =
                                                      "done";
                                                  seat += " B11";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B11")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[10] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[10] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B11", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B11")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B11")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[11] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[11] =
                                                      "done";
                                                  seat += " B12";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B12")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[11] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[11] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B12", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B12")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B12")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    state.seat[0].floors2[12] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[12] =
                                                      "done";
                                                  seat += " B13";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B13")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[12] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[12] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B13", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B13")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B13")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[13] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  print("Khong the chon them");
                                                } else {
                                                  state.seat[0].floors2[13] =
                                                      "done";
                                                  seat += " B14";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B14")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[13] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors1[13] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B14", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B14")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B14")
                                                  ],
                                                ),
                                              ),
                                    state.seat[0].floors2[14] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[14] =
                                                      "done";
                                                  seat += " B15";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B15")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[14] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[14] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B15", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B15")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B15")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                    ),
                                    state.seat[0].floors2[15] == "trong"
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (seat.length >= 19) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Khong the them nua!'),
                                                  ));
                                                } else {
                                                  state.seat[0].floors2[15] =
                                                      "done";
                                                  seat += " B16";
                                                  count++;
                                                }
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/svg/seat.svg',
                                                  color: Colors.blue,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text("B16")
                                              ],
                                            ),
                                          )
                                        : state.seat[0].floors2[15] == "done"
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    state.seat[0].floors2[15] =
                                                        "trong";
                                                    count--;
                                                    seat = seat.replaceAll(
                                                        "B16", " ");
                                                    seat =
                                                        replaceWhitespacesUsingRegex(
                                                            seat, ' ');
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.red,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B16")
                                                  ],
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {},
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/svg/seat.svg',
                                                      color: Colors.grey,
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text("B16")
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      state.seat[0].floors2[16] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors2[16] =
                                                        "done";
                                                    seat += " B17";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("B17")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors2[16] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors2[16] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "B17", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B17")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B17")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors2[17] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors2[17] =
                                                        "done";
                                                    seat += " B18";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("B18")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors2[17] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors2[17] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "B18", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B18")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B18")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors2[18] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors2[18] =
                                                        "done";
                                                    seat += " B19";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("B19")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors2[18] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors2[18] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "B19", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B19")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B19")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors2[19] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors2[19] =
                                                        "done";
                                                    seat += " B20";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("B20")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors2[19] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors2[19] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "B20", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B20")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B20")
                                                    ],
                                                  ),
                                                ),
                                      state.seat[0].floors2[20] == "trong"
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (seat.length >= 19) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Khong the them nua!'),
                                                    ));
                                                  } else {
                                                    state.seat[0].floors2[20] =
                                                        "done";
                                                    seat += " B21";
                                                    count++;
                                                  }
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/svg/seat.svg',
                                                    color: Colors.blue,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Text("B21")
                                                ],
                                              ),
                                            )
                                          : state.seat[0].floors2[20] == "done"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      state.seat[0]
                                                              .floors2[20] =
                                                          "trong";
                                                      count--;
                                                      seat = seat.replaceAll(
                                                          "B21", " ");
                                                      seat =
                                                          replaceWhitespacesUsingRegex(
                                                              seat, ' ');
                                                    });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.red,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B21")
                                                    ],
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/svg/seat.svg',
                                                        color: Colors.grey,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      Text("B21")
                                                    ],
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Ghế đã chọn"),
                                          Spacer(),
                                          Text(seat == null ? " " : seat)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Tổng tiền"),
                                          Spacer(),
                                          Text(
                                              "${count * int.parse(widget.price)} VND")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Trống")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.redAccent),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Đang chọn")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Đã đặt")
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: DefaultButton(
                                  press: () {},
                                  text: "Tiep tuc",
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ));
  }

  String replaceWhitespacesUsingRegex(String s, String replace) {
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, replace);
  }
}
