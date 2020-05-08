import 'package:flutter/material.dart';
import 'package:jiitexpense/model/order.dart';
import 'package:jiitexpense/shared/widgets/timer.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
  final Order order;
  final String orderId;
  const PlaceOrder({Key key, this.order, this.orderId}) : super(key: key);
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed Succesfully'),
      ),
      body: Column(
        children: <Widget>[
          Text('Waiting Time : ${widget.order.totalEstimatedTime}'),
          TimeToOrder(totalDuration: widget.order.totalEstimatedTime, start: widget.order.dateTime,),
          Text('${widget.orderId}'),
        ],
      ),
    );
  }
}
