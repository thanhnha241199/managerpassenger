import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Code Scanner & Generator'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanScreen()),
                  );
                },
                child: const Text('SCAN QR CODE')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateScreen()),
                  );
                },
                child: const Text('GENERATE QR CODE')),
          ),
        ],
      )),
    );
  }
}

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  String seat = "";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
          centerTitle: false,
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
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.qr_code_outlined,
                    color: Colors.black,
                    size: 150,
                  ),
                  Icon(
                    Icons.fullscreen,
                    color: Colors.black,
                    size: 350,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')),
              ),
              seat == ""
                  ? Text("")
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "ID Tour: ",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${barcode}",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Seat: ",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${seat.trim()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      List<String> result = barcode.split(" ");
      print(result);
      setState(() {
        this.barcode = result[0];
        for (int i = 1; i < result.length; i++) {
          if (i == result.length - 1) {
            this.seat += result[i];
          } else {
            this.seat += result[i] + "-";
          }
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = ' ');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();
  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(context),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // final tempDir = await getTemporaryDirectory();
      // final file = await new File('${tempDir.path}/image.png').create();
      // await file.writeAsBytes(pngBytes);

      // final channel = const MethodChannel('channel:me.camellabs.share/share');
      // channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter a custom message",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      child: Text("SUBMIT"),
                      onPressed: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Screenshot(
                controller: screenshotController,
                child: RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        QrImage(
                          data: _dataString,
                          size: 0.5 * bodyHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _imageFile = null;
              screenshotController
                  .capture(delay: Duration(milliseconds: 10))
                  .then((Uint8List image) async {
                setState(() {
                  _imageFile = image;
                });
                final result = await ImageGallerySaver.saveImage(image);
                print(result);
                showDialog(
                  context: context,
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("CAPURED SCREENSHOT"),
                    ),
                    body: Center(
                        child: Column(
                      children: [
                        _imageFile != null ? Image.memory(image) : Container(),
                      ],
                    )),
                  ),
                );
                Reference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child('images/');
                UploadTask uploadTask = firebaseStorageRef.putData(image);
                TaskSnapshot taskSnapshot = await uploadTask;
                taskSnapshot.ref.getDownloadURL().then((value) {
                  print(value);
                });
                print("File Saved to Gallery");
              }).catchError((onError) {
                print(onError);
              });
            },
            child: Text("Save Image"),
          ),
          TextButton(
              child: Text('Download Image'),
              onPressed: () async {
                var _image = MemoryImage(_imageFile);

                // TODO implement JavaScript to download image
              })
        ],
      ),
    );
  }
}

class DetailWidget extends StatefulWidget {
  String _filePath;
  DetailWidget(this._filePath);

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                final channel =
                    const MethodChannel('channel:me.camellabs.share/share');
                channel.invokeMethod('shareFile', 'image.png');
              },
            )
          ],
        ),
        body: Container(
          child: SizedBox(
            height: 500.0,
            child: new Center(
                child: widget._filePath == null
                    ? Text('No Image')
                    : Container(
                        child: Image.file(File(widget._filePath),
                            fit: BoxFit.fitWidth))),
          ),
        ));
  }
}
