import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/model/addressmodel.dart';
import 'package:managepassengercar/common/widgets/stateless/custom_input.dart';
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
    // TODO: implement dispose
    addressController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressBloc>(context).add(DoFetchEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Add address",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
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
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    isExpanded: true,
                    items: list_city.map((dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem.name,
                        child: Text(dropDownStringItem.name),
                      );
                    }).toList(),
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
                  list_district == null
                      ? Text("")
                      : DropdownButton<String>(
                          isExpanded: true,
                          items: list_district.map((dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem.name,
                              child: Text(dropDownStringItem.name),
                            );
                          }).toList(),
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
                  list_ward == null
                      ? Text("")
                      : DropdownButton<String>(
                          isExpanded: true,
                          items: list_ward.map((dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem.name,
                              child: Text(dropDownStringItem.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              ward = value;
                            });
                          },
                          value: ward,
                        ),
                  CustomInput(
                    controller: addressController,
                    hintText: "Address...",
                    textInputAction: TextInputAction.done,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    child: DefaultButton(
                      press: () {
                        Navigator.pop(context, addressController.text);
                      },
                      text: "Confirm",
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
