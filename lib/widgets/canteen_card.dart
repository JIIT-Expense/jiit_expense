import 'package:flutter/material.dart';
import 'package:jiitexpense/models/canteen.dart';

class CanteenCard extends StatelessWidget {

  Function onClick;
  Canteen canteen;
  CanteenCard({ this.onClick, this.canteen });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          this.onClick(this.canteen);
        },
        child: Card(

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(canteen.name),
                SizedBox(height: 3),
                Text(canteen.contact),
                SizedBox(height: 3),
                Text(canteen.location)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
