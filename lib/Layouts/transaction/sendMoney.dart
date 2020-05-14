import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    if (this.barcode == "") {
      return Scaffold(
        appBar: AppBar(
          title: Text('Scan to send money'),
        ),
        body: RaisedButton(
          onPressed: scan,
          child: Text('Scan'),
        ),
      );
    } else {
      String userId = barcode.split("__")[0];
      String canteenId = barcode.split("__")[1];
      return Scaffold(
        appBar: AppBar(
          title: Text('Scanned Result'),
        ),
        body: Column(
          children: <Widget>[
            Text(userId),
            Text(canteenId)
          ],
        ),
      );
    }
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode.rawContent;
      });
    } on PlatformException catch(e) {
      setState(() {
        this.barcode = e.message;
      });
      }
    }
}
