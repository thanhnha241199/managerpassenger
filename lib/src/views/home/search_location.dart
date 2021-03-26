import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final _startPointController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter MapBox AutoComplete example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: CustomTextField(
          hintText: "Select starting point",
          textController: _startPointController,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapBoxAutoCompleteWidget(
                  apiKey:
                      "mapbox://styles/thanhnha241199/ckmoly5740kzw17mhdzw8d7r5",
                  hint: "Select starting point",
                  onSelect: (place) {
                    // TODO : Process the result gotten
                    _startPointController.text = place.placeName;
                  },
                  limit: 10,
                ),
              ),
            );
          },
          enabled: true,
        ),
      ),
    );
  }
}
