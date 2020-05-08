import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/model/wallet.dart';
import 'package:jiitexpense/services/wallet/wallet.dart';
import 'package:provider/provider.dart';

class WalletLayout extends StatefulWidget {
  @override
  _WalletLayoutState createState() => _WalletLayoutState();
  final String canteenId;
  const WalletLayout({Key key, this.canteenId}): super(key: key);
}

class _WalletLayoutState extends State<WalletLayout> {


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<Wallet>(
      stream: WalletService().getWalletBalanceStream(widget.canteenId, user.uid),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Text('Error Database connection');
        }
        if (!snapshot.hasData) {
          return Loading();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Wallet'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_balance_wallet, size: 50,),
                    SizedBox(width: 40,),
                    Text(
                        '${snapshot.data.balance} Rs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        print('');
                      },
                      child: Text('Add Money'),
                    ),
                  ],
                ),
                Text('Recent Transactions'),
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Text('Recent Orders # 1');
                      }
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
