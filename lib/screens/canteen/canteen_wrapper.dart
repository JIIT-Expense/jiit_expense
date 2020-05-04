import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/shared/loading.dart';
import 'package:provider/provider.dart';

class CanteenWrapper extends StatelessWidget {

  final Function onChange;
  CanteenWrapper({this.onChange});

  @override
  Widget build(BuildContext context) {
    final List<Canteen> canteens = Provider.of<List<Canteen>>(context);
    return canteens == null ? Loading() : DropdownButton(
      hint: Text('Please choose a Canteen'),
      onChanged: (val) {
        onChange(val);
      },
      items: canteens.map((canteen) {
        return DropdownMenuItem(
          child: new Text(canteen.name),
          value: canteen,
        );
      }).toList(),
    );
  }
}
