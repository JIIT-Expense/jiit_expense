import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/order/order.dart';
import 'package:jiitexpense/Layouts/transaction/transaction.dart';
import 'package:jiitexpense/Layouts/wallet/wallet.dart';
import 'package:jiitexpense/services/cart/cart.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
  final String canteenId;
  const HomeWrapper({Key key, this.canteenId}): super(key: key);
}

class _HomeWrapperState extends State<HomeWrapper> {
  List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
    ChangeNotifierProvider<CartBloc>(
      create: (BuildContext context) {
        return CartBloc();
      },
      child: Order(canteenId: widget.canteenId),
      ),
      WalletLayout(canteenId: widget.canteenId),
      Transaction(canteenId: widget.canteenId)
    ];
  }
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // this will be set when a new tab is tapped
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance_wallet),
            title: new Text('Wallet'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              title: Text('Send or Recieve')
          )
        ],
      ),
    );
  }
}
