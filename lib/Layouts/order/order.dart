import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/checkout/checkout.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/model/menuItem.dart';
import 'package:jiitexpense/model/menuItems.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:jiitexpense/services/cart/cart.dart';
import 'package:jiitexpense/services/menuItem/menuItem.dart';
import 'package:jiitexpense/shared/widgets/menu_item.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
  final String canteenId;
  const Order({Key key, this.canteenId}): super(key: key);
}

class _OrderState extends State<Order> {

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {

    var cartBloc = Provider.of<CartBloc>(context);
    int totalItemsInCart = cartBloc.getSize();

    var streamBuilder = StreamBuilder<MenuItems>(
      stream: MenuItemService().stream(widget.canteenId),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Text('Error Loading Database');
        }
          else if (!snapshot.hasData) {
            return Loading();
          }
          else {
            List<MenuItem> menuItems = snapshot.data.menuItems;
            return Scaffold(
              appBar: AppBar(
                title: Text('Order'),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout(cart: cartBloc, menuItem: menuItems, canteenId: widget.canteenId,)));
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
              body: menuItems.length == 0 ? Text('No items added yet in the Menu..Try back later') : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return MenuItemWidget(menuItem: menuItems[index], menuItemIndex: index, updateQuantity: cartBloc.addToCart,);
//                    return MenuItem(itemName: this.menuItems[index]);
                      },
                    ),
                  ),
                ],
              ),

            );
        }
      },
    );

    return streamBuilder;
  }

  updateQuantity(int selectedCanteenIndex, int menuItemIndex, int quantity) {

  }
}
