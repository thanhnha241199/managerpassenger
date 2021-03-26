import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:managepassengercar/src/models/schedule.dart';

class ChedulesBus extends StatefulWidget {
  String id;
  ChedulesBus({this.id});
  @override
  _ChedulesBusState createState() => _ChedulesBusState();
}

class _ChedulesBusState extends State<ChedulesBus> {
  Map<String, dynamic> _schedule;
  bool _loading;
  String locationstart = "aaaa,", locationend = "aaaaa";

  Future<Schedule> getHttp() async {
    try {
      Response response = await Dio().get(
          'https://managerpassenger.herokuapp.com/getschedule',
          queryParameters: {
            "idtour": widget.id,
          });
      if (response != null && response.statusCode == 200) {
        setState(() {
          _schedule = response.data;
          schedule = _schedule['schedule'];
          print(schedule);
        });
      }
    } catch (e) {
      print(e);
    }
  }
  List<dynamic> schedule;
  bool check;
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _loading = true;
    isLoading = true;
    getHttp().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            isLoading ? "Loading" : "Lịch trình",
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Stack(children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thông tin chuyến đi",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _schedule['locationstart'],
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.arrow_forward),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            _schedule['locationend'],
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("") ,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text("Thoi gian"),
                            ),
                            Expanded(
                              flex: 3,
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text("Dia diem"),
                              )
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemBuilder: (context, index){
                            return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: index ==0 ? Icon(Icons.radio_button_off_outlined) : index==schedule.length-1 ?Icon(Icons.check) : Icon(Icons.radio_button_checked_outlined),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(schedule[index]['time']),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: ListTile(
                                      title: Text(schedule[index]['location']),
                                      subtitle: Text(schedule[index]['address']),
                                    ),
                                  ),
                                ],
                              );
                          },
                          itemCount: schedule.length,
                        )

                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Some placeholder content to show off the line height utilities. Happy birthday. You could've been the greatest. She ride me like a roller coaster. I messed around and got addicted. You just gotta ignite the light and let it shine! I'm intrigued, for a peek, heard it's fascinating. Catch her if you can. I should've told you what you meant to me 'Cause now I pay the price. Do you ever feel, feel so paper thin."),
                      Text(
                          "But you better choose carefully. Yo, shout out to all you kids, buying bottle service, with your rent money. She's sweet as pie but if you break her heart. Just own the night like the 4th of July! In another life I would be your girl. Playing ping pong all night long, everything's all neon and hazy. Shorty so bad, I’m sprung and I don’t care."),
                      Text(
                          "I can feel a phoenix inside of me. Maybe a reason why all the doors are closed. We go higher and higher. Passport stamps, she's cosmopolitan. Someone said you had your tattoo removed. All my girls vintage Chanel baby. Someone said you had your tattoo removed."),
                      Text(
                          "But I will get there. This is real so take a chance and don't ever look back, don't ever look back. You could travel the world but nothing comes close to the golden coast. Of anything and everything. Venice beach and Palm Springs, summertime is everything. Do you ever feel already buried deep six feet under? It's time to bring out the big balloons. So cover your eyes, I have a surprise. So I don't have to say you were the one that got away."),
                    ],
                  ),
                ),
              ])));
  }
}
