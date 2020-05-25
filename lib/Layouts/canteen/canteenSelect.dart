import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/home/homeWrapper.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/model/user.dart';
import 'package:jiitexpense/services/auth/auth.dart';
import 'package:jiitexpense/services/canteen/canteen.dart';
import 'package:jiitexpense/services/wallet/wallet.dart';
import 'package:provider/provider.dart';

class CanteenSelect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    updateSelectedCanteen(String uid) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeWrapper(canteenId: uid)));
    }

    User user = Provider.of<User>(context);

    var futureBuilder = new FutureBuilder(
      future: CanteenService().fetchCanteens(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting: return Loading();
          default:
            if (snapshot.hasError) {
              return Text('Error Connecting');
            } else {
              return Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => Loading()));
//                          print('start');
                          await WalletService().addWallet(user.uid, snapshot.data[index].uid);
//                          print('end');
//                          Navigator.pop(context);
                          updateSelectedCanteen(snapshot.data[index].uid);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              child: Center(
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(color: Colors.white, fontSize: 36.0),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
        }
      },
    );



    return Scaffold(
      appBar: AppBar(
        title: Text('Select Canteen'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout'),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
      ),
        body: futureBuilder,
    );
  }
}
