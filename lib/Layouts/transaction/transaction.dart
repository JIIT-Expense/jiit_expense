import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
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
                print('');
              },
              child: Text('Send'),
            ),
            SizedBox(height: 30,),
            RaisedButton(
              onPressed: () {
                print('');
              },
              child: Text('Recieve'),
            ),
          ],
        ),
      ),
    );;
  }
}
