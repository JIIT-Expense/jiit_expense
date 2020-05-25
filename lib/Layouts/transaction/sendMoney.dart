import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/model/wallet.dart';
import 'package:jiitexpense/services/wallet/wallet.dart';
import 'package:jiitexpense/shared/constants/text_input_decoration.dart';
import 'package:provider/provider.dart';

import '../loading.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String barcode = "";
  String amount = "";
  String error = "";

  String amountValidator(String value) {
    Pattern pattern = r'^(0*[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*)$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Amount format is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (this.barcode == "") {
      return Scaffold(
        appBar: AppBar(
          title: Text('Scan to send money'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: scan,
            child: Text('Start Scan'),
          ),
        ),
      );
    } else {
      String userId = barcode.split("__")[0];
      String canteenId = barcode.split("__")[1];
      return Scaffold(
        appBar: AppBar(
          title: Text('Scanned Result'),
        ),
        body: StreamBuilder<Wallet>(
            stream: WalletService().getWalletBalanceStream(canteenId, user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error Database connection');
              }
              if (!snapshot.hasData) {
                return Loading();
              }
              return Column(
                children: <Widget>[
                  Text(userId),
                  Text(canteenId),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: '1000 Rs.'),
                        validator: amountValidator,
                        onChanged: (amount) {
                          setState(() {
                            this.amount = amount;
                          });
                        }),
                  ),
                  RaisedButton(
                    child: Text('Send'),
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Loading()));
                      await WalletService().sendMoney(user.uid, userId, canteenId, snapshot.data.balance, int.parse(this.amount));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                      'Your current Wallet balance is ${snapshot.data.balance}'),
                  Text('$error',
                  style: TextStyle(color: Colors.red),)
                ],
              );
            }),
      );
    }
  }

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode.rawContent;
      });
    } on PlatformException catch (e) {
      setState(() {
        this.barcode = e.message;
      });
    }
  }
}
