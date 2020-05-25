import 'package:flutter/material.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveMoney extends StatefulWidget {
  @override
  _ReceiveMoneyState createState() => _ReceiveMoneyState();
  final String canteenId;
  const ReceiveMoney({Key key, this.canteenId}): super(key: key);
}

class _ReceiveMoneyState extends State<ReceiveMoney> {



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recieve Money from another user'),
      ),
      body: Column(
        children: <Widget>[
          QrImage(
            data: '${user.uid}__${widget.canteenId}',
            version: QrVersions.auto,
          ),
          Text(user.uid),
          Text(widget.canteenId),
        ],
      ),
    );
  }
}
