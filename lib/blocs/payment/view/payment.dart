import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/payment/view/pay.dart';
import 'package:managepassengercar/blocs/payment/bloc/payment_bloc.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    // TODO: implement initState
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
                    colors: [Colors.red[900], Colors.blue[700]])),
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(EvaIcons.creditCardOutline),
                      ),
                      Text(
                        "Nạp tài khoản FUTAPay",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SuccessState) {
                    return state.card.length == 0
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MySample()));
                            },
                            child: Container(
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
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
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Bằng việc liên kết thẻ, bạn đồng ý với Điểu khoản sử dụng của FUTAPay",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Hỗ trợ thanh toán thẻ Visa/MasterCard/JCB Debit, ATM nội địa.",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Thẻ được xác thực liên kết bằng giao dịch 5000đ ( được hoàn trả lại sau khi xác thực)",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Hệ thống FUTA không lưu thông tin thẻ, chỉ lưu thông tin thanh toán để tiện cho lần thanh toán sau này.",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Đồng ý cho FUTA thực hiện thanh toán tự động cho chuyến đi khi chọn thanh toán qua thẻ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  RadioListTile(
                                    groupValue: "Agree to the terms",
                                    title: Text(
                                      "Agree to the terms",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExistingCardsPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quan ly the ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
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
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Bằng việc liên kết thẻ, bạn đồng ý với Điểu khoản sử dụng của FUTAPay",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Hỗ trợ thanh toán thẻ Visa/MasterCard/JCB Debit, ATM nội địa.",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Thẻ được xác thực liên kết bằng giao dịch 5000đ ( được hoàn trả lại sau khi xác thực)",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Hệ thống FUTA không lưu thông tin thẻ, chỉ lưu thông tin thanh toán để tiện cho lần thanh toán sau này.",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "- Đồng ý cho FUTA thực hiện thanh toán tự động cho chuyến đi khi chọn thanh toán qua thẻ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  RadioListTile(
                                    groupValue: "Agree to the terms",
                                    title: Text(
                                      "Agree to the terms",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
