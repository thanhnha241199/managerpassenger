import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)),
            child: Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                alignment: AlignmentDirectional.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            value: null,
                            strokeWidth: 5.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: Text(
                            "Loading.....",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]))),
      ),
    );
  }
}
