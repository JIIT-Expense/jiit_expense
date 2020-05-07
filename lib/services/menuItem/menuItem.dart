import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/menuItem.dart';
import 'package:jiitexpense/model/menuItems.dart';

class MenuItemService {
  Firestore firestore = Firestore.instance;
  String db_path = 'MenuItem';

  Stream<MenuItems> stream(String canteenId) {
    return firestore.collection(db_path).document(canteenId).snapshots().map((menuItem) => MenuItems.fromMap(menuItem.data, menuItem.documentID));
  }




}