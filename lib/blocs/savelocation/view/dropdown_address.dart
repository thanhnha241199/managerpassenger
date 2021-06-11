import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/model/addressmodel.dart';
import 'package:managepassengercar/blocs/savelocation/view/autocomplete.dart';
import 'package:managepassengercar/src/utils/constants.dart';
import 'package:managepassengercar/src/views/widget/default_btn.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController addressController = new TextEditingController();

  String city;
  String district;
  String ward;
  List<AddressModel> list_city;
  List<District> list_district;
  List<Ward> list_ward;
  @override
  void dispose() {
    addressController.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressBloc>(context).add(DoFetchEvent());
  }

  PlaceApiProvider apiClient;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          tr('addAddress'),
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
      body: BlocBuilder<AddressBloc, AddressState>(
        buildWhen: (previous, current) {
          if (previous is SuccessState && current is LoadingState) {
            return false;
          } else {
            return true;
          }
        },
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
            list_city = state.addressmodel;
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          tr('city'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items: list_city.map((dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem.name,
                                  child: Text(dropDownStringItem.name),
                                );
                              }).toList(),
                              hint: Text(
                                tr('chooseCity'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  city = value;
                                  list_city.forEach((element) {
                                    if (element.name == city) {
                                      list_district = element.districts;
                                    }
                                  });
                                });
                              },
                              value: city,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tr('quan'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        list_district == null
                            ? Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      items: [],
                                      onChanged: (value) {},
                                      isExpanded: true,
                                      hint: Text(
                                        tr('choosequan'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ))
                            : Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    items:
                                        list_district.map((dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem.name,
                                        child: Text(dropDownStringItem.name),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      'choosequan',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        district = value;
                                        list_district.forEach((element) {
                                          if (element.name == district) {
                                            list_ward = element.wards;
                                          }
                                        });
                                      });
                                    },
                                    value: district,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tr('xa'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        list_ward == null
                            ? Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      items: [],
                                      onChanged: (value) {},
                                      isExpanded: true,
                                      hint: Text(
                                        tr('choosexa'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ))
                            : Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: list_ward.map((dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem.name,
                                        child: Text(dropDownStringItem.name),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      tr('choosexa'),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        ward = value;
                                      });
                                    },
                                    value: ward,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1.2,
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
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
                        style: Constants.regularDarkText,
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                        child: AnimatedButton(
                          color: Colors.red,
                          text: tr('confirm'),
                          pressEvent: () {
                            Navigator.pop(
                                context,
                                addressController.text +
                                    ", " +
                                    ward +
                                    ", " +
                                    district +
                                    ", " +
                                    city);
                          },
                        ))
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
