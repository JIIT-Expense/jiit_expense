import 'package:jiitexpense/model/menuItemWithQuantity.dart';

class Order {
  final List<MenuItemWithQuantity> items;
  final int totalAmount;
  final int totalEstimatedTime;
  final String userId;
  final DateTime dateTime;
  final String canteenId;
  String uid;

  Order({this.items, this.totalAmount, this.totalEstimatedTime, this.userId, this.dateTime, this.canteenId, this.uid});

  Order.fromMap(Map snapshot, String uid) :
      totalAmount = snapshot['totalAmount'],
      totalEstimatedTime = snapshot['totalEstimatedWaitingTime'],
      userId = snapshot['user'],
      dateTime = snapshot['dateTime'].toDate() as DateTime,
      canteenId = snapshot['canteenId'],
      uid = uid,
      items = (snapshot['items'] as List).map((val) =>
        MenuItemWithQuantity(
            name: val['name'],
            cost: val['price'],
            waitingTime: val['estimatedTime'],
            availability: val['availability'],
            quantity: val['quantity']
        )
      ).toList();


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