import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeToOrder extends StatefulWidget {
  @override
  _TimeToOrderState createState() => _TimeToOrderState();
  final DateTime start;
  final int totalDuration;
  const TimeToOrder({Key key,this.start, this.totalDuration}): super(key: key);
}

class _TimeToOrderState extends State<TimeToOrder> {

  @override
  Widget build(BuildContext context) {
    DateTime orderDeliverDate = widget.start.add(Duration(minutes: widget.totalDuration));
    return Column(
      children: <Widget>[
        Text('${DateFormat('').add_jm().format(orderDeliverDate)}'),

      ],
    );
  }
}