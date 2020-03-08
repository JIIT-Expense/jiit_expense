import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiitexpense/models/brew.dart';
import 'package:jiitexpense/services/auth.dart';
import 'package:jiitexpense/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {

    void showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text('Bottom Sheet'),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Homepage'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
                onPressed: () => showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }


}
