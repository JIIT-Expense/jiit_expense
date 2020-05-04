import 'package:flutter/material.dart';
import 'package:jiitexpense/models/menu_item.dart';

class MenuItemCard extends StatefulWidget {

  final MenuItem menuItem;
  MenuItemCard({this.menuItem});

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {

  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Card(
          color: quantity > 0 ? Colors.brown[300] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                        widget.menuItem.name,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '$quantity added to cart',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.quantity += 1;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.quantity == 0 ? this.quantity = 0 : this.quantity -= 1;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
