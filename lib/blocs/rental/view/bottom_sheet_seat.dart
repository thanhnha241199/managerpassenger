import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomSheetRadioSeat extends StatefulWidget {
  BottomSheetRadioSeat(
      {@required this.switchValue, @required this.valueChanged});

  final bool switchValue;
  final ValueChanged valueChanged;

  @override
  _BottomSheetRadioSeat createState() => _BottomSheetRadioSeat();
}

class _BottomSheetRadioSeat extends State<BottomSheetRadioSeat> {
  bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        tr("quanseat"),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                _switchValue = true;
                                widget.valueChanged(true);
                              });
                              Navigator.pop(context);
                            },
                            selected: _switchValue,
                            title: Text(tr("4seat")),
                            trailing: _switchValue
                                ? Icon(Icons.check_circle, color: Colors.red)
                                : Icon(Icons.radio_button_unchecked),
                          ),
                          ListTile(
                            onTap: () {
                              setState(() {
                                _switchValue = false;
                                widget.valueChanged(false);
                              });
                              Navigator.pop(context);
                            },
                            selected: !_switchValue,
                            title: Text(tr("16seat")),
                            trailing: !_switchValue
                                ? Icon(Icons.check_circle, color: Colors.red)
                                : Icon(Icons.radio_button_unchecked),
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
