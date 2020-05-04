import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/models/user.dart';
import 'package:jiitexpense/screens/canteen/canteen_wrapper.dart';
import 'package:jiitexpense/screens/home/menu_items.dart';
import 'package:jiitexpense/services/auth.dart';
import 'package:jiitexpense/services/canteen.dart';
import 'package:jiitexpense/widgets/canteen_card.dart';
import 'package:jiitexpense/widgets/user_canteen_details.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  Canteen currCanteen;


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    onChangeDropDown(Canteen canteen) {
      setState(() {
        currCanteen = canteen;
      });
    }

    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Select a Canteen'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: StreamProvider<List<Canteen>>.value(
                  value: CanteenService().canteens(),
                  child: this.currCanteen == null ? CanteenWrapper(onChange: onChangeDropDown) : Column(
                    children: <Widget>[
                      CanteenWrapper(onChange : onChangeDropDown),
                      CanteenCard(canteen: currCanteen),
                      Expanded(
                          child: MenuItems(canteen: this.currCanteen)
                      ),
                    ],
                  ),
                ),
        ),
    );
  }
}
