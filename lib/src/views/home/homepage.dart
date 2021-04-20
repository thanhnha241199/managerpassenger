import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/ticket/view/buy_ticket.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/chat/chatuserscreen.dart';
import 'package:managepassengercar/src/views/chat/global.dart';
import 'package:managepassengercar/src/views/chat/user.dart';
import 'package:managepassengercar/blocs/rental/view/rental.dart';
import 'package:managepassengercar/src/views/infor/licence.dart';
import 'package:managepassengercar/src/views/test.dart';
import 'package:managepassengercar/src/views/widget/icon_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final UserRepository userRepository;

  Home({Key key, @required this.userRepository}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var check;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return tr("morning");
    }
    if (hour < 17) {
      return tr("afternoon");
    }
    return tr("night");
  }

  void checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('email');
    G.initDummyUsers();
    UserChat userA = new UserChat(
        id: prefs.getString('id'),
        name: prefs.getString('name'),
        email: prefs.getString('email'));
    G.loggedInUser = userA;
    setState(() {
      check = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[400], Colors.blue[900]])),
            height: MediaQuery.of(context).size.height * 0.3),
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 35.0, left: 10.0, bottom: 25.0),
              child: check != null
                  ? Text(
                      "${greeting()}, ${check}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    )
                  : Text(
                      "${greeting()} !",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      padding: EdgeInsets.only(top: 10.0),
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      children: [
                        IconMenu(Colors.white, "assets/icons/menu/tickets.png",
                            tr("menu1"), Ticket(), context),
                        IconMenu(
                            Colors.white,
                            "assets/icons/menu/school-bus.png",
                            tr("menu5"),
                            RentalScreen(),
                            context),
                        IconMenu(
                            Colors.white,
                            "assets/icons/menu/car-rental.png",
                            tr("menu3"),
                            RentalScreen(),
                            context),
                        IconMenu(Colors.white, "assets/icons/menu/taxi.png",
                            tr("menu4"), RentalScreen(), context),
                        IconMenu(
                            Colors.white,
                            "assets/icons/menu/delivery-man.png",
                            tr("menu2"),
                            MyLocation(),
                            context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Licence()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0)),
                              child: Image.network(
                                "https://worldcourier.vn/wp-content/uploads/2020/12/gui-qua-tang-tet-co-truyen-cho-nguoi-than.png",
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height / 3.65,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Mua vé Tết 2021",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 4.0),
                              child:
                                  Text("Các lưu ý về quy định mua vé Tết 2021"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Ticket()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0)),
                              child: Image.network(
                                "https://storage.googleapis.com/facecar-29ae7.appspot.com/office/requirement/0000c050-8635-11eb-95a2-ab62bc6a0b71-1615884775637.jpg",
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height / 3.65,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Thanh toán dịch vụ thuận tiện",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 4.0),
                              child: Text(
                                  "Thanh toán dịch vụ FUTA tiện lợi bằng ví....."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Các tuyến xe phổ biến",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.6,
                    // width: double.infinity,
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      crossAxisCount: 1,
                      childAspectRatio: 0.85,
                      mainAxisSpacing: 8.0,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://file4.batdongsan.com.vn/2020/11/04/b9sp0zUm/20201104114642-05ed.jpg",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.4,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Khai trương tuyến mới",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Cần Thơ - Năm Căn, Cần Thơ - Vũng Tàu"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://www.lasinfoniadelreyhotel.com/img/upload/ho_guom.gif",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "HÀ NỘI - ĐÀ NẴNG",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Ra mắt dịch vụ xe VIP 34 giường cho bạn thoải mái chuyến đi."),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://media-cdn.laodong.vn/Storage/NewsPortal/2019/2/2/655949/Kinh-Nghiem-Hanh-Huo.jpg?w=414&h=276&crop=auto&scale=both",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "SÀI GÒN - CHÂU ĐỐC",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Ra mắt dịch vụ xe VIP 34 giường cho bạn thoải mái chuyến đi."),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://thamhiemmekong.com/wp-content/uploads/2020/06/thanh-pho-ha-tien.jpg",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "SÀI GÒN - HÀ TIÊN",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Ra mắt dịch vụ xe VIP 34 giường cho bạn thoải mái chuyến đi."),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://nucuoimekong.com/wp-content/uploads/du-lich-sai-gon.jpg",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "SÀI GÒN - CẦN THƠ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Ra mắt dịch vụ xe VIP 34 giường cho bạn thoải mái chuyến đi."),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ticket()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0)),
                                    child: Image.network(
                                      "https://ik.imagekit.io/tvlk/apr-asset/dgXfoyh24ryQLRcGq00cIdKHRmotrWLNlvG-TxlcLxGkiDwaUSggleJNPRgIHCX6/hotel/asset/20021333-420316a7983472a744286a5ababf860e.jpeg?tr=q-40,c-at_max,w-740,h-500&_src=imagekit",
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.6,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "HÀ NỘI - NAM ĐỊNH",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 4.0),
                                    child: Text(
                                        "Ra mắt dịch vụ xe VIP 34 giường cho bạn thoải mái chuyến đi."),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentalScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0)),
                              child: Image.network(
                                "https://media-exp1.licdn.com/dms/image/C4D1BAQEwXA7zSrVQSA/company-background_10000/0/1561661794399?e=2159024400&v=beta&t=k5OvVShEhula6n-HOxZA2vX27pM1jNBbjNFJENEU6Hg",
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height / 3.65,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Xe hop dong",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 4.0),
                              child: Text(
                                  "Thue xe hop dong, dat xe du lich tien loi, nhanh chong."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (pref.getString("token") == null) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                headerAnimationLoop: true,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Bạn chưa đăng nhập',
                desc: 'Vui lòng đăng nhập để có thể tiếp tục sử dung!',
                buttonsTextStyle: TextStyle(color: Colors.black),
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                              userRepository: widget.userRepository)));
                },
              )..show();
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatUsersScreen()));
            }
          },
          child: SvgPicture.asset('assets/icons/svg/chat.svg')),
    );
  }
}
