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
        Text(
            'Time : ${DateFormat('').add_jm().add_yMMMMd().format(widget.start)}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          'Collect Order After : ${DateFormat('').add_jm().format(orderDeliverDate)}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
