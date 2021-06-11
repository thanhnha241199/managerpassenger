import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/view/form_location.dart';

class SaveLocation extends StatefulWidget {
  @override
  _SaveLocationState createState() => _SaveLocationState();
}

class _SaveLocationState extends State<SaveLocation> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    BlocProvider.of<AddressBloc>(context).add(DoFetchEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          tr('savelocation'),
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        brightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
        elevation: 0,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormLocation()));
            },
            icon: Icon(
              EvaIcons.plusOutline,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FailureState) {
              return Scaffold(
                body: Center(
                  child: Text(state.msg),
                ),
              );
            }
            if (state is SuccessState) {
              return state.address.length != 0
                  ? Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              "Location favorite",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.address.length,
                                  itemBuilder: (context, index) {
                                    return AddressContainer(
                                        state.address[index].title,
                                        state.address[index].address,
                                        state.address[index].uid,
                                        state.address[index].id);
                                  })),
                        ),
                      ],
                    )
                  : Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black12
                          : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/screen/9_Location_Error.png",
                            fit: BoxFit.cover,
                          ),
                          Text(
                            tr('notaddress'),
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget AddressContainer(
      String title, String subtitle, String uid, String id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(
                  Icons.turned_in,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  size: 35,
                ),
              ),
              trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormLocation(
                                  title: title,
                                  address: subtitle,
                                  uid: uid,
                                  id: id,
                                )));
                  },
                  child: Icon(Icons.keyboard_arrow_right,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      size: 30.0)))),
    );
  }
}
