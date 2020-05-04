import 'package:jiitexpense/models/menu_item.dart';

class Canteen {
  final String uid;
  final String name;
  final String location;
  final String contact;
  final List<MenuItem> menuItems;

  Canteen({this.name, this.uid, this.contact, this.location, this.menuItems});

}