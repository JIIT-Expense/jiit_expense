import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/checkout/checkout.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:jiitexpense/services/cart/cart.dart';
import 'package:jiitexpense/shared/widgets/horizontal_selector.dart';
import 'package:jiitexpense/shared/widgets/menu_item.dart';
import 'package:jiitexpense/shared/globals.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
  final int canteenIndex;
  const Order({Key key, this.canteenIndex}): super(key: key);
}

class _OrderState extends State<Order> {
  final List<String> menuItems = ["MenuItem 3", "MenuItem 4", "MenuItem 3", "MenuItem 4", "MenuItem 3", "MenuItem 4", "MenuItem 3", "MenuItem 4", "MenuItem 3", "MenuItem 4", "MenuItem 3", "MenuItem 4"];

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {

    var cartBloc = Provider.of<CartBloc>(context);
    int totalItemsInCart = cartBloc.getSize();
    return  Scaffold(
        appBar: AppBar(
          title: Text('Order'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout(menuItems: menuItems)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.4),
                child: Badge(
                  badgeContent: Text('$totalItemsInCart'),
                  child: Icon(Icons.shopping_cart),
                  badgeColor: Colors.white,
                ),
              ),
            ),

            FlatButton(
              child: Text('Logout'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ],
        ),
        body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: this.menuItems.length,
                  itemBuilder: (context, index) {
                    return MenuItem(itemName: this.menuItems[index], menuItemIndex: index, updateQuantity: cartBloc.addToCart,);
//                    return MenuItem(itemName: this.menuItems[index]);
                  },
                ),
              ),
          ],
        ),

      );
  }

  updateQuantity(int selectedCanteenIndex, int menuItemIndex, int quantity) {

  }
}
