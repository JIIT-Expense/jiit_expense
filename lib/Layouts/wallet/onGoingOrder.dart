import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/Layouts/wallet/wallet.dart';
import 'package:jiitexpense/model/order.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/services/order/order.dart';
import 'package:jiitexpense/shared/widgets/orderTile.dart';

class OnGoingOrders extends StatelessWidget {
  const OnGoingOrders({
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
