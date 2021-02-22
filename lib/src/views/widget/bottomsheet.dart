import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void _modalBottomSheetMenu4(context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.grey[350],
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(3.0),
                    topRight: const Radius.circular(3.0))),
            //content starts
            child: new Container(
              margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
// rounded rectangle grey handle
                  new Container(
                    width: 40.0,
                    height: 5.0,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      color: Colors.grey,
                    ),
                  ),

                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // new SvgPicture.asset(
                      //   "assets/lang.svg",
                      //   width: 80.0,
                      //   height: 80.0,
                      // ),
                      new Text("\nSelect Language\n",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new CupertinoButton(
                          //special button for ios on click fadecolor
                          onPressed: () async {
                            // Navigator.pop(context);
                            // Navigator.of(context).push(new MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         new GreetingPage()));
                          },
                          child: new Text(" Tamil "),
                          color: CupertinoColors.activeBlue,
                          pressedOpacity: 0.4,
                          //opactiy default 0.1
                          minSize: 44.0, //its has min length
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new CupertinoButton(
                          //special button for ios on click fadecolor
                          onPressed: () async {
                            // Navigator.pop(context);
                            // Navigator.of(context).push(new MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         new GreetingPageEng()));
                          },
                          child: new Text("English"),
                          color: CupertinoColors.destructiveRed,
                          pressedOpacity: 0.4,
                          //opactiy default 0.1
                          minSize: 44.0, //its has min length
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        );
      });
}
