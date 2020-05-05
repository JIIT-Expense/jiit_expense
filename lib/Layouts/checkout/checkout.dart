import 'package:flutter/material.dart';
import 'package:jiitexpense/services/cart/cart.dart';
import 'package:jiitexpense/shared/widgets/menu_item.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
  final List<String> menuItem;
  const Checkout({Key key, this.menuItem}): super(key: key);
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    var cartBloc = Provider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        automaticallyImplyLeading: true
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: cartBloc.getSize(),
                itemBuilder: (context, index) {
                  cartBloc.cart.forEach((menuItemIndex, quantity) => )
                }

            ),
          )
          Text('Show total in bill format'),
          Text('button to give order')
        ],
      ),
    );
  }
}
