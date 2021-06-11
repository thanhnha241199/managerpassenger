import 'package:flutter/material.dart';
import 'package:managepassengercar/blocs/ticket/model/discount.dart';
import 'package:managepassengercar/src/utils/constants.dart';

class Voucher extends StatefulWidget {
  List<Discount> discount;
  Voucher({this.discount});
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  TextEditingController voucherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Voucher",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
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
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 1.8,
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      controller: voucherController,
                      decoration: InputDecoration(
                          hintText: "Voucher",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 20.0,
                          )),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      int number = widget.discount.indexWhere((element) =>
                          element.code.toUpperCase() ==
                          voucherController.text.toUpperCase());
                      if (number != -1) {
                        Navigator.pop(context, widget.discount[number].sale);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Apply success'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Apply failed'),
                        ));
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Text("Add"),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 90),
                alignment: Alignment.topCenter,
                child: Text(
                  "Voucher co the ap dung",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
            Container(
              padding: EdgeInsets.only(top: 110),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.discount.length,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: CircleAvatar(
                              backgroundColor: Colors.red.withOpacity(0.6),
                              child: Icon(
                                Icons.card_giftcard_outlined,
                                color: Colors.black,
                              ))),
                      title: Text(
                        widget.discount[index].title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.discount[index].sale.toString() +
                                "% - " +
                                widget.discount[index].code,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            widget.discount[index].description,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            widget.discount[index].timeend,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
