import 'package:flutter/material.dart';
import 'package:jiitexpense/services/cart/cart.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
  final List<String> menuItem;
  final CartBloc cart;
  const Checkout({Key key, this.menuItem, this.cart}) : super(key: key);
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout'), automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Here are your added Items',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Quantity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Expanded(
              child: widget.cart.getSize() == 0 ? Text('You need to add some items here') : ListView.builder(
                itemCount: widget.cart.getSize(),
                itemBuilder: (context, index) {
                  int key = widget.cart.cart.keys.elementAt(index);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.menuItem[key],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${widget.cart.cart[key]}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Total : 335',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              RaisedButton(
                  onPressed: () {
                    print('Checked out');
                  },
                  child: Text('Place Order'),
                  color: Colors.blue,
                  
              ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
