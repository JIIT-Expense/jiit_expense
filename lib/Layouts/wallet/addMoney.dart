import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
  final String canteenId;
  final String userId;
  const AddMoney({Key key, this.canteenId, this.userId}): super(key: key);
}

class _AddMoneyState extends State<AddMoney> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add balance to the canteen'),
      ),
      body: Column(
        children: <Widget>[
          QrImage(
            data: '${widget.userId}__${widget.canteenId}',
            version: QrVersions.auto,
          )
        ],
      ),
    );
  }
}
