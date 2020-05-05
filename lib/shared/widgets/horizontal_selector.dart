import 'package:flutter/material.dart';

class HorizontalSelector extends StatelessWidget {
  final List<String> list;
  final Function updateSelected;
  final int selectedIndex;
  const HorizontalSelector({Key key, this.list, this.selectedIndex, this.updateSelected }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              this.updateSelected(index);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                border: index == selectedIndex ? Border.all(color: Colors.blue[700]) : null,
              ),
              child: Card(
                color: Colors.blue,
                child: Container(
                  child: Center(
                      child: Text(
                        list[index],
                        style: TextStyle(color: Colors.white, fontSize: 36.0),
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
