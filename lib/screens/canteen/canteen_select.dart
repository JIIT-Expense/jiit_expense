import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/screens/home/menu_items.dart';
import 'package:jiitexpense/services/canteen.dart';
import 'package:jiitexpense/widgets/canteen_card.dart';

class CanteenSelect extends StatefulWidget {

  final List<Canteen> canteens;
  CanteenSelect({ this.canteens });

  @override
  _CanteenSelectState createState() => _CanteenSelectState();
}

class _CanteenSelectState extends State<CanteenSelect> {
  CanteenService canteenService = CanteenService();

  @override
  Widget build(BuildContext context) {

      void onClick(Canteen canteen) {
        print(canteen.name);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuItems(canteen: canteen)));
      }

      return ListView.builder(
        itemCount: widget.canteens.length,
        itemBuilder: (context, index) {
          return CanteenCard(canteen: widget.canteens[index], onClick: onClick);
        },
      );
    }
}
