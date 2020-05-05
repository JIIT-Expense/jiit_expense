import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  @override
  _MenuItemState createState() => _MenuItemState();
  final String itemName;
  final int menuItemIndex;
  final Function updateQuantity;
  const MenuItem({Key key, this.itemName, this.menuItemIndex, this.updateQuantity}): super(key: key);
}

class _MenuItemState extends State<MenuItem> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Card(
        color: quantity > 0 ? Colors.blue[200] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    widget.itemName,
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
                    this.quantity == 0 ? this.quantity = 0 : this.quantity -= 1;
                    widget.updateQuantity(widget.menuItemIndex, quantity);
                  });
                },
                icon: Icon(Icons.remove),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    this.quantity += 1;
                    widget.updateQuantity(widget.menuItemIndex, quantity);
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
