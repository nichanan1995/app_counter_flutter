import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
//import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";
 //int _counter = 0; 

 void _incrementCounter() {

   setState(() {
    //_counter++;
   });
 }


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('QR Counter'),
            actions: <Widget>[IconButton(tooltip: 'upload',
            icon: Icon(Icons.cloud_upload),onPressed: (){},)],
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  
                  
                ),
                
                Text(barcode),
               

              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
                          onPressed: scan,
                      child: Icon(Icons.add_a_photo)),
                  //padding: const EdgeInsets.all(8.0),
          ),

    );
  }


  Future sendtoserver(data) async {
    print('============');
    print(data);
    print('============');

    var url = 'http://androidthai.in.th/sun/addDataOill.php';
    var response = await http.post(url, body: {'isAdd': 'true', 'Barcode': data});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);

      //sendtoserver(this.barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}