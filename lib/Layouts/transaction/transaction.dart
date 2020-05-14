import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/transaction/recieveMoney.dart';
import 'package:jiitexpense/Layouts/transaction/sendMoney.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
  final String canteenId;
  const Transaction({Key key, this.canteenId}): super(key: key);
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SendMoney())
                );
              },
              child: Text('Send'),
            ),
            SizedBox(height: 30,),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReceiveMoney(canteenId: widget.canteenId,))
                );
              },
              child: Text('Recieve'),
            ),
          ],
        ),
      ),
    );
  }
}
