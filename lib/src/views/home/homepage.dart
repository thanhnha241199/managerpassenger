import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/src/views/widget/icon_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              padding: const EdgeInsets.only(
                  top: 45.0, left: 10.0, bottom: 25.0),
              child: Text(
                "Chào buổi sáng, thanhnha241199",
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
                        IconMenu(Colors.red, EvaIcons.carOutline,
                            "Mua Vé Phương Trang"),
                        IconMenu(Colors.blueAccent, EvaIcons.attach2,
                            "Gọi TAXI"),
                        IconMenu(
                            Colors.grey, EvaIcons.carOutline, "Gọi Ô TÔ"),
                        IconMenu(Colors.green, EvaIcons.carOutline,
                            "Xe Hợp Đồng"),
                        IconMenu(Colors.yellow, EvaIcons.carOutline,
                            "Gọi Xe 2 Bánh"),
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
                              height: 190,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Mua vé Tết 2021",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, bottom: 4.0),
                            child: Text(
                                "Các lưu ý về quy định mua vé Tết 2021"),
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
                              height: 190,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                                    height: 177,
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
                                    height: 177,
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
                                    height: 177,
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
                                    height: 177,
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
                                    height: 177,
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
                                    height: 177,
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
                              height: 190,
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
                              height: 190,
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
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/homeapp");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

