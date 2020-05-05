import 'package:flutter/material.dart';
import 'package:jiitexpense/Layouts/home/homeWrapper.dart';
import 'package:jiitexpense/shared/widgets/horizontal_selector.dart';

class CanteenSelect extends StatelessWidget {
  final List<String> canteens = ["Canteen 1", "Canteen 2"];



  @override
  Widget build(BuildContext context) {
    updateSelectedCanteen(int index) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeWrapper(canteenIndex: index)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Canteen'),
      ),
        body: Center(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.canteens.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  updateSelectedCanteen(index);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Card(
                    color: Colors.blue,
                    child: Container(
                      child: Center(
                          child: Text(
                            canteens[index],
                            style: TextStyle(color: Colors.white, fontSize: 36.0),
                          )),
                    ),
                  ),
                ),
              );
            },
          ),
      ),
        ),
    );
  }
}
