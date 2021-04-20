import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/payment/view/add_card.dart';
import 'package:managepassengercar/blocs/payment/view/card_existed.dart';
import 'package:managepassengercar/blocs/payment/bloc/payment_bloc.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  final UserRepository userRepository;

  Payment({Key key, @required this.userRepository}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool check = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentBloc>(context).add(DoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Thanh Toán",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[400], Colors.blue[900]])),
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          EvaIcons.creditCardOutline,
                          size: 40,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Nạp tài khoản FUTAPay",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PaymentBloc, PaymentState>(
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
                  if (state is SuccessState) {
                    return state.card.length == 0
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Liên kết thẻ: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddCard()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          "https://www.freeiconspng.com/uploads/visa-icon-0.png",
                                          height: 60,
                                          width: 60,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Liên kết thẻ Visa/Master/ JCB",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway'),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.add),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Bằng việc liên kết thẻ, bạn đồng ý với Điểu khoản sử dụng của FUTAPay:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Hỗ trợ thanh toán thẻ Visa/MasterCard/JCB Debit, ATM nội địa.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Thẻ được xác thực liên kết bằng giao dịch 5000đ ( được hoàn trả lại sau khi xác thực)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Hệ thống FUTA không lưu thông tin thẻ, chỉ lưu thông tin thanh toán để tiện cho lần thanh toán sau này.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Đồng ý cho FUTA thực hiện thanh toán tự động cho chuyến đi khi chọn thanh toán qua thẻ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      check
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  check = !check;
                                                });
                                              },
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  check = !check;
                                                });
                                              },
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Đồng ý với điều khoản",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quản lý thẻ: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CardExisted()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          "https://www.freeiconspng.com/uploads/visa-icon-0.png",
                                          height: 60,
                                          width: 60,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Liên kết thẻ Visa/Master/ JCB",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Bằng việc liên kết thẻ, bạn đồng ý với Điểu khoản sử dụng của FUTAPay:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Hỗ trợ thanh toán thẻ Visa/MasterCard/JCB Debit, ATM nội địa.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Thẻ được xác thực liên kết bằng giao dịch 5000đ ( được hoàn trả lại sau khi xác thực)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Hệ thống FUTA không lưu thông tin thẻ, chỉ lưu thông tin thanh toán để tiện cho lần thanh toán sau này.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "- Đồng ý cho FUTA thực hiện thanh toán tự động cho chuyến đi khi chọn thanh toán qua thẻ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      check
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  check = !check;
                                                });
                                              },
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  check = !check;
                                                });
                                              },
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Đồng ý với điều khoản",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Liên kết thẻ: ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        GestureDetector(
                          onTap: () async {
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
                                btnOkOnPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage(
                                              userRepository:
                                                  widget.userRepository)));
                                },
                              )..show();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://www.freeiconspng.com/uploads/visa-icon-0.png",
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Liên kết thẻ Visa/Master/ JCB",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "Bằng việc liên kết thẻ, bạn đồng ý với Điểu khoản sử dụng của FUTAPay:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "- Hỗ trợ thanh toán thẻ Visa/MasterCard/JCB Debit, ATM nội địa.",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Raleway'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "- Thẻ được xác thực liên kết bằng giao dịch 5000đ ( được hoàn trả lại sau khi xác thực)",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Raleway'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "- Hệ thống FUTA không lưu thông tin thẻ, chỉ lưu thông tin thanh toán để tiện cho lần thanh toán sau này.",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Raleway'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "- Đồng ý cho FUTA thực hiện thanh toán tự động cho chuyến đi khi chọn thanh toán qua thẻ",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Raleway'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              check
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          check = !check;
                                        });
                                      },
                                      child: Icon(
                                        Icons.check_box_rounded,
                                        color: Colors.redAccent,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          check = !check;
                                        });
                                      },
                                      child: Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Đồng ý với điều khoản",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
