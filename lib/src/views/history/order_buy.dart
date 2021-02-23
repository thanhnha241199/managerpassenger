import 'package:flutter/material.dart';

class OrderBuy extends StatefulWidget {
  @override
  _OrderBuyState createState() => _OrderBuyState();
}

class _OrderBuyState extends State<OrderBuy> {
  int selectRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectRadio = 1;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Đơn mua",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            selected: selectRadio.compareTo(1) == 0 ? true : false,
            title: Text("Tuyen pho bien"),
            trailing: Radio(
              activeColor: Colors.red,
              value: 1,
              groupValue: selectRadio,
              onChanged: (value) {
                setSelectedRadio(value);
              },
            ),
          ),
          ListTile(
            selected: selectRadio.compareTo(0) == 0 ? true : false,
            title: Text("Khuyen mai"),
            trailing: Radio(
              activeColor: Colors.red,
              value: 0,
              groupValue: selectRadio,
              onChanged: (value) {
                setSelectedRadio(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
