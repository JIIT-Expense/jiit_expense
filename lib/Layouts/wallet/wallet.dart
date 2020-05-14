import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/Layouts/wallet/addMoney.dart';
import 'package:jiitexpense/Layouts/wallet/prevOrder.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/model/wallet.dart';
import 'package:jiitexpense/services/order/order.dart';
import 'package:jiitexpense/services/wallet/wallet.dart';
import 'package:jiitexpense/shared/widgets/orderTile.dart';
import 'package:provider/provider.dart';
import 'package:jiitexpense/model/order.dart';


class WalletLayout extends StatefulWidget {
  @override
  _WalletLayoutState createState() => _WalletLayoutState();
  final String canteenId;
  const WalletLayout({Key key, this.canteenId}): super(key: key);
}

class _WalletLayoutState extends State<WalletLayout> {


  bool onGoingOrder = true;
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    Widget showOrders() {
      if (onGoingOrder) {
        return onGoingOrders(user: user, widget: widget,);
      }
      return prevOrder(user: user, widget: widget,);
    }
    Widget showChangeButton() {
      if (onGoingOrder) {
        return RaisedButton(
          child: Text('Previous Orders'),
          onPressed: () {
            setState(() {
              this.onGoingOrder = !this.onGoingOrder;
            });
          },
        );
      }
      return RaisedButton(
        child: Text('Current Orders'),
        onPressed: () {
          setState(() {
            this.onGoingOrder = !this.onGoingOrder;
          });
        },
      );
    }
    return StreamBuilder<Wallet>(
      stream: WalletService().getWalletBalanceStream(widget.canteenId, user.uid),
      builder: (context, snapshot) {
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
                    SizedBox(width: 10,),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddMoney(canteenId: widget.canteenId, userId: user.uid,))
                        );
                      },
                      child: Text('Add Money'),
                    ),
                  ],
                ),

                showChangeButton(),
                SizedBox(height: 20,),
                showOrders(),
              ],
            ),
          ),
        );
      }
    );
  }
}



class onGoingOrders extends StatelessWidget {
  const onGoingOrders({
    Key key,
    @required this.user,
    @required this.widget,
  }) : super(key: key);

  final User user;
  final WalletLayout widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Order>> (
        stream: OrderService().getOnGoingOrderList(user.uid, widget.canteenId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text('error');
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return OrderTile(order: snapshot.data[index], completed: false);
            },
          );
        },
      ),
    );
  }
}
