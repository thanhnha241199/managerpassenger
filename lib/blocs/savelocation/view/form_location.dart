import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/view/dropdown_address.dart';

import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/test.dart';
import 'package:managepassengercar/src/views/widget/blur_dialog.dart';
import 'package:managepassengercar/utils/app_style.dart';

class FormLocation extends StatefulWidget {
  final String title;
  final String address;
  final String uid;
  final String id;

  FormLocation({this.title, this.address, this.uid, this.id});

  @override
  _FormLocationState createState() => _FormLocationState();
}

class _FormLocationState extends State<FormLocation> {
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = widget.address ?? null;
    nameController.text = widget.title ?? null;
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.title == null ? tr('addAddress') : tr('updateAddress'),
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('nameAddress'),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 11,
              width: MediaQuery.of(context).size.width / 1.2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12.0)),
              child: TextField(
                maxLines: 10,
                controller: nameController,
                decoration: InputDecoration(
                    hintText: tr('nameAddress'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    )),
                style: AppTextStyles.textSize16(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('detailAddress'),
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.turned_in),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddress()))
                            .then((value) {
                          setState(() {
                            addressController.text = value;
                          });
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.pin_drop_outlined),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLocation()))
                            .then((value) {
                          setState(() {
                            addressController.text = value;
                          });
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12.0)),
              child: TextField(
                maxLines: 10,
                controller: addressController,
                decoration: InputDecoration(
                    hintText: tr('detailAddress'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    )),
                style: AppTextStyles.textSize16(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is UpdateSuccessState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Cập nhật thành công!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
            Navigator.pop(context);
          }
          if (state is UpdateFailureState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Update failed!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
          }
          if (state is UpdateNullState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Tên và địa chỉ không được để trống!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
          }
          if (state is AddSuccessState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Thêm thành công!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
            Navigator.pop(context);
          }
          if (state is AddFailureState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Add failed!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
          }
          if (state is AddNullState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Tên và địa chỉ không được để trống!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
          }
          if (state is DeleteSuccessState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Xoa thành công!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
            Navigator.pop(context);
          }
          if (state is DeleteFailureState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Delete failed!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            return Container(
              height: 56,
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Row(
                children: <Widget>[
                  widget.address == null
                      ? Text("")
                      : state is DeleteLoadingState
                          ? Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()))
                          : Expanded(
                              flex: 1,
                              child: AnimatedButton(
                                color: Colors.red,
                                text: tr('delete'),
                                pressEvent: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.QUESTION,
                                    headerAnimationLoop: true,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: tr("alertlogin"),
                                    desc: tr('descriptionLogin'),
                                    buttonsTextStyle:
                                        TextStyle(color: Colors.black),
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                      BlocProvider.of<AddressBloc>(context)
                                          .add(DeleteEvent(id: widget.id));
                                    },
                                  )..show();
                                },
                              )),
                  SizedBox(
                    width: 5,
                  ),
                  widget.address != null
                      ? state is UpdateLoadingState
                          ? Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()))
                          : Expanded(
                              flex: 1,
                              child: AnimatedButton(
                                color: Colors.green,
                                text: tr('update'),
                                pressEvent: () {
                                  BlocProvider.of<AddressBloc>(context).add(
                                      UpdateEvent(
                                          id: widget.id,
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim()));
                                },
                              ))
                      : state is AddLoadingState
                          ? Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()))
                          : Expanded(
                              flex: 1,
                              child: AnimatedButton(
                                color: Colors.red,
                                text: tr('add'),
                                pressEvent: () async {
                                  BlocProvider.of<AddressBloc>(context).add(
                                      AddEvent(
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim()));
                                },
                              )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Places Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Places Autocomplete Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              readOnly: true,
              onTap: () async {
                // generate a new token here
                // final sessionToken = Uuid().v4();
                // final Suggestion result = await showSearch(
                //   context: context,
                //   delegate: AddressSearch(sessionToken),
                // );
                // // This will change the text displayed in the TextField
                // if (result != null) {
                //   final placeDetails = await PlaceApiProvider(sessionToken)
                //       .getPlaceDetailFromId(result.placeId);
                //   setState(() {
                //     _controller.text = result.description;
                //     _streetNumber = placeDetails.streetNumber;
                //     _street = placeDetails.street;
                //     _city = placeDetails.city;
                //     _zipCode = placeDetails.zipCode;
                //   });
                // }
              },
              decoration: InputDecoration(
                icon: Container(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your shipping address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Street Number: $_streetNumber'),
            Text('Street: $_street'),
            Text('City: $_city'),
            Text('ZIP Code: $_zipCode'),
          ],
        ),
      ),
    );
  }
}
