import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:managepassengercar/blocs/login/view/login.dart';
import 'package:managepassengercar/blocs/ticket/view/buy_ticket.dart';
import 'package:managepassengercar/repository/profile_repository.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/models/profile_user.dart';
import 'package:managepassengercar/src/views/chat/chatuserscreen.dart';
import 'package:managepassengercar/src/views/chat/global.dart';
import 'package:managepassengercar/src/views/chat/user.dart';
import 'package:managepassengercar/src/views/home/search_location.dart';
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
    var status = prefs.getString('name');
    setState(() {
      check = status;
    });
  }

  ProfileRepository profileRepository;
  Future<ProfileUser> user;
  Future<ProfileUser> fetchProfileUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Dio dio = new Dio();
    ProfileUser profileUser;
    dio.options.headers['Authorization'] = 'Bearer ${token}';
    Response response =
        await dio.get("https://managerpassenger.herokuapp.com/getinfo");
    if (response != null && response.statusCode == 200) {
      profileUser = ProfileUser.fromJson(response.data);
      return profileUser;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
    G.initDummyUsers();
    if (check != null) {
      user = fetchProfileUser();
      user.then((value) {
        UserChat userA =
            new UserChat(id: value.id, name: value.name, email: value.email);
        G.loggedInUser = userA;
      });
    }
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
                    colors: [Colors.red[900], Colors.blue[700]])),
            height: MediaQuery.of(context).size.height * 0.3),
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 45.0, left: 10.0, bottom: 25.0),
              child: Text(
                "${greeting()}, ${check}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      padding: EdgeInsets.only(top: 10.0),
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      children: [
                        IconMenu(Colors.red, EvaIcons.carOutline, tr("menu1"),
                            Ticket(), context),
                        IconMenu(Colors.blueAccent, EvaIcons.attach2,
                            tr("menu2"), MyLocation(), context),
                        IconMenu(Colors.grey, EvaIcons.carOutline, tr("menu3"),
                            Home1(), context),
                        IconMenu(Colors.green, EvaIcons.carOutline, tr("menu4"),
                            MyLocation(), context),
                        IconMenu(Colors.yellow, EvaIcons.carOutline,
                            tr("menu5"), Home1(), context),
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
                                height:
                                    MediaQuery.of(context).size.height / 3.05,
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
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
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
                              "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                              height: MediaQuery.of(context).size.height / 3.05,
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
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: Text(
                                "Thanh toán dịch vụ FUTA tiện lợi bằng ví....."),
                          )
                        ],
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
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Xem thêm",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
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
                                    "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Thanh toán dịch vụ thuận tiện",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
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
                              "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                              height: MediaQuery.of(context).size.height / 3.05,
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
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: Text(
                                "Thanh toán dịch vụ FUTA tiện lợi bằng ví....."),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
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
                              "https://img.idesign.vn/1920x-/2019/06/08/ides_chinese_01.jpg",
                              height: MediaQuery.of(context).size.height / 3.05,
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
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: Text(
                                "Thanh toán dịch vụ FUTA tiện lợi bằng ví....."),
                          )
                        ],
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(userRepository: widget.userRepository)));
            } else {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatUsersScreen()));
            }
          },
          child: SvgPicture.asset('assets/icons/svg/chat.svg')),
    );
  }
}
