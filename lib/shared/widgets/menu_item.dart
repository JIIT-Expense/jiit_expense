import 'package:flutter/material.dart';
import 'package:jiitexpense/model/menuItem.dart';

class MenuItemWidget extends StatefulWidget {
  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
  final MenuItem menuItem;
  final int menuItemIndex;
  final Function updateQuantity;
  const MenuItemWidget(
      {Key key,
      this.menuItem,
      this.menuItemIndex,
      this.updateQuantity,})
      : super(key: key);
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
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
                    '${widget.menuItem.name}',
                  ),
                  Text(
                    '$quantity / ${widget.menuItem.availability}',
                  ),
                  Text(
                      '${widget.menuItem.cost} Rs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (!(this.quantity == 0)) {
                      quantity--;
                      widget.updateQuantity(widget.menuItemIndex, quantity);
                    }
                  });
                },
                icon: Icon(Icons.remove),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (this.quantity < widget.menuItem.availability) {
                      this.quantity += 1;
                      widget.updateQuantity(widget.menuItemIndex, quantity);
                    }
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
