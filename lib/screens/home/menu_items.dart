import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/models/menu_item.dart';
import 'package:jiitexpense/widgets/menu_item_card.dart';

class MenuItems extends StatefulWidget {

  final Canteen canteen;
  MenuItems({ this.canteen });
  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {

  @override
  Widget build(BuildContext context) {
    List<MenuItem> lis = widget.canteen.menuItems;
    return widget.canteen == null ? Text('Loading') : ListView.builder(
      itemCount: lis.length,
        itemBuilder: (context, index) {
            return MenuItemCard(menuItem: lis[index]);
        },
    );
  }
}
