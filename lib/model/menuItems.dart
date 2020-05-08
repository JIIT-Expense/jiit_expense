import 'package:jiitexpense/model/menuItem.dart';

class MenuItems {
  final String uid;
  final List<MenuItem> menuItems;

  MenuItems({this.menuItems, this.uid});

  MenuItems.fromMap(Map snapshot, String id) :
        menuItems = ((snapshot['items'] as List).map((item) => MenuItem(
          name: item['name'] ?? '',
          availability: item['availability'] ?? 0,
          waitingTime: item['waitingTime'] ?? 0,
          cost: item['cost'] ?? 0,
          )).toList() as List<MenuItem>),
        uid = id;

  toJson() {
    List<Map> itemList = List();
    menuItems.forEach((val) => {
      itemList.add({
        'availability': val.availability,
        'cost': val.cost,
        'name': val.name,
        'waitingTime': val.waitingTime
      })
    });
    return {
      'items' : itemList
    };
  }
}
