import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: Container(
          margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 40.0,
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
                        horizontal: 20, vertical: 10.0),
                    child: selectRadio == "1"
                        ? Text(
                      "Tuyến phổ biến",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                        : Text(
                      "Khuyen mai",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
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
                      )),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
