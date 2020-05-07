import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/home/homeWrapper.dart';
import 'package:jiitexpense/Layouts/loading.dart';
import 'package:jiitexpense/services/canteen/canteen.dart';

class CanteenSelect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    updateSelectedCanteen(String uid) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeWrapper(canteenId: uid)));
    }

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
                        onTap: () {
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
      ),
        body: futureBuilder,
    );
  }
}
