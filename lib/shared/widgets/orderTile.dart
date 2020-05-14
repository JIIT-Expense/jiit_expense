import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiitexpense/Layouts/order/placeOrder.dart';
import 'package:jiitexpense/model/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool completed;

  const OrderTile({Key key, this.order, this.completed}): super(key : key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
      child: Card(
        color: completed ? Colors.green : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceOrder(
                        order: order,
                        isOnGoingOrder: !completed,
                      )));
            },
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Order Id : '),
                    Text('${order.uid}')
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${order.totalAmount} Rs',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text('${DateFormat('').add_jm().add_yMMMMd().format(order.dateTime)}',
                      style: TextStyle(
                        fontSize: 17
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
