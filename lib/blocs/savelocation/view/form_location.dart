import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/view/dropdown_address.dart';
import 'package:managepassengercar/src/views/test.dart';
import 'package:managepassengercar/src/views/widget/blur_dialog.dart';

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
    // TODO: implement initState
    super.initState();
    addressController.text = widget.address ?? null;
    nameController.text = widget.title ?? null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Add location",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: "Name location",
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(), // Move focus to next
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.category),
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
                      icon: Icon(Icons.location_city_outlined),
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
            TextField(
              controller: addressController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: "Address",
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => node.unfocus(), // Submit and hide keyboard
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
                'Them thành công!',
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
                              child: GestureDetector(
                                onTap: () {
                                  _showDialog(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text("Delete",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                            ),
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
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AddressBloc>(context).add(
                                      UpdateEvent(
                                          id: widget.id,
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim()));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text("Update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                            )
                      : state is AddLoadingState
                          ? Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()))
                          : Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AddressBloc>(context).add(
                                      AddEvent(
                                          id: "603315cf7c9ba513e47d3e28",
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim()));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () {
      BlocProvider.of<AddressBloc>(context).add(DeleteEvent(id: widget.id));
      Navigator.pop(context);
    };
    BlurryDialog alert = BlurryDialog("Abort",
        "Are you sure you want to abort this operation?", continueCallBack);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
