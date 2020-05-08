import 'package:jiitexpense/model/menuItem.dart';
import 'package:jiitexpense/model/menuItemWithQuantity.dart';

class Order {
  final List<MenuItemWithQuantity> items;
  final int totalAmount;
  final int totalEstimatedTime;
  final String userId;
  final DateTime dateTime;
  final String canteenId;

  Order({this.items, this.totalAmount, this.totalEstimatedTime, this.userId, this.dateTime, this.canteenId});

  toJson() {
    List<Map> itemList = List();
    items.forEach((val) => itemList.add({
      'availability': val.availability,
      'estimatedTime': val.waitingTime,
      'name': val.name,
      'price': val.cost,
      'quantity': val.quantity,
    }));
    return {
      'items': itemList,
      'totalAmount': totalAmount,
      'dateTime': DateTime.now(),
      'user': userId,
      'totalEstimatedWaitingTime': totalEstimatedTime,
      'canteenId': canteenId,
    };
  }
}