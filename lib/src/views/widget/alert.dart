
//
// void _modalBottomSheetMenu4(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (builder) {
//         return Container(
//           height: 200.0,
//           color: Colors.grey[350],
//           child: Container(
//             decoration: new BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: const Radius.circular(3.0),
//                     topRight: const Radius.circular(3.0))),
//             child: Container(
//               margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
//               child: new Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   new Container(
//                     width: 40.0,
//                     height: 5.0,
//                     decoration: new BoxDecoration(
//                       borderRadius: new BorderRadius.circular(10.0),
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(5.0),
//                         child: CupertinoButton(
//                           onPressed: () async {
//                             // Navigator.pop(context);
//                             // Navigator.of(context).push(new MaterialPageRoute(
//                             //     builder: (BuildContext context) =>
//                             //         new GreetingPage()));
//                           },
//                           child: new Text(" Tamil "),
//                           color: CupertinoColors.activeBlue,
//                           pressedOpacity: 0.4,
//                           //opactiy default 0.1
//                           minSize: 44.0, //its has min length
//                         ),
//                       ),
//                       new Container(
//                         padding: EdgeInsets.all(5.0),
//                         child: new CupertinoButton(
//                           //special button for ios on click fadecolor
//                           onPressed: () async {
//                             // Navigator.pop(context);
//                             // Navigator.of(context).push(new MaterialPageRoute(
//                             //     builder: (BuildContext context) =>
//                             //         new GreetingPageEng()));
//                           },
//                           child: new Text("English"),
//                           color: CupertinoColors.destructiveRed,
//                           pressedOpacity: 0.4,
//                           //opactiy default 0.1
//                           minSize: 44.0, //its has min length
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30.0),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }