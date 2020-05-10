import 'package:flutter/material.dart';
import 'package:jiitexpense/model/order.dart';
import 'package:jiitexpense/shared/widgets/timer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
  final Order order;
  final String orderId;
  final bool isOnGoingOrder;
  const PlaceOrder({Key key, this.order, this.orderId, this.isOnGoingOrder}) : super(key: key);
}

class _PlaceOrderState extends State<PlaceOrder> {

  textWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }
  textWidgetHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
  @override
  Widget build(BuildContext context) {

    String heading = widget.isOnGoingOrder ? 'Show this to canteen order to accept order' : 'Here is you order';
    String status = widget.isOnGoingOrder ? 'Pending' : 'Completed';
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Placed Succesfully'),
      ),
      body: Column(
              children: <Widget>[
                Text(
                  '$heading',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                QrImage(
                  data: widget.orderId,
                  version: QrVersions.auto,
                  size: 250,
                ),
                TimeToOrder(
                  totalDuration: widget.order.totalEstimatedTime,
                  start: widget.order.dateTime,
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Table(
                    children: getOrderItems(),
                  ),
                ),
                textWidgetHeading('Order Status : $status'),
        ],
      ),
    );
  }

  getOrderItems() {
    List<TableRow> row = List();
    row.add(TableRow(
        children: [
          textWidgetHeading('Item'),
          textWidgetHeading('Price'),
          textWidgetHeading('Quantity'),
        ]
    ));
    widget.order.items.forEach((val) => {
      row.add(TableRow( children : [
          textWidget('${val.name}'),
          textWidget('${val.cost}'),
          textWidget('${val.quantity}'),
    ]))
    });
    return row;
  }
}
