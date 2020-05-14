import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/menuItem.dart';
import 'package:jiitexpense/model/menuItems.dart';
import 'package:jiitexpense/model/order.dart';

class MenuItemService {
  Firestore firestore = Firestore.instance;
  String dbPath = 'MenuItem';

  Stream<MenuItems> stream(String canteenId) {
    return firestore.collection(dbPath).document(canteenId).snapshots().map((menuItem) => MenuItems.fromMap(menuItem.data, menuItem.documentID));
  }

  deductAvailability(Order order, List<MenuItem>menuItemList) async {
//    firestore.collection(db_path).document(canteenId).s

    List<MenuItem> listMenuItem = List();
    Map<String, int> nameToQuantity = Map();
    order.items.forEach((val) => {
      nameToQuantity[val.name] = val.quantity
    });
    menuItemList.forEach((val) => {
      listMenuItem.add(
          MenuItem(
            name: val.name,
            availability: nameToQuantity.containsKey(val.name) ? val.availability-nameToQuantity[val.name] : val.availability,
            cost: val.cost,
            waitingTime: val.waitingTime,))
    });
    MenuItems menuToUpdate = MenuItems(menuItems: listMenuItem, uid: order.canteenId);
    await firestore.collection(dbPath).document(order.canteenId).setData(menuToUpdate.toJson());
  }
}