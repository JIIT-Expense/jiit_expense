import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/menuItem.dart';
import 'package:jiitexpense/model/menuItemWithQuantity.dart';
import 'package:jiitexpense/model/menuItems.dart';
import 'package:jiitexpense/model/order.dart';
import 'package:jiitexpense/services/menuItem/menuItem.dart';
import 'package:jiitexpense/services/wallet/wallet.dart';

class OrderService {
  Firestore firestore = Firestore.instance;
  String onGoingOrderPath = 'ongoingOrder';
  String pastOrderPath = 'pastOrder';


  checkOrder(String userId, List<MenuItem> menuItems, List<int> quantity, String canteenId, int walletBalance) {

    DateTime now = DateTime.now();
    List<MenuItemWithQuantity> items = List();
    int totalAmount = 0;
    int totalEstimatedTime = 0;
    for (var i = 0; i < menuItems.length; i++) {
      items.add(MenuItemWithQuantity(
          name: menuItems[i].name,
          availability: menuItems[i].availability,
          quantity: quantity[i],
          cost: menuItems[i].cost,
          waitingTime: menuItems[i].waitingTime
      ));
      totalAmount += menuItems[i].cost * quantity[i];
      totalEstimatedTime += menuItems[i].waitingTime * quantity[i];
    }
    Order order = Order(
        userId: userId,
        dateTime: now,
        items: items,
        totalAmount: totalAmount,
        totalEstimatedTime: totalEstimatedTime,
        canteenId: canteenId
    );
    return order;
  }

  placeOrder(Order order, int walletBalance, List<MenuItem> menuItemList) async {
    if (walletBalance >= order.totalAmount) {
      await _deductAmount(order.totalAmount, walletBalance, order.canteenId, order.userId);
      await _deductAvailableItem(order, menuItemList);
      var result = await _placeOrder(order);
      print(result.documentID);
      return result.documentID;
    }
    return '';
  }

  _deductAmount(int totalAmount, int walletBalance, String canteenId, String userId) async {
    await WalletService().updateAmount(walletBalance-totalAmount, canteenId, userId);
  }

  Future<DocumentReference> _placeOrder(Order order) async {
    return await firestore.collection(onGoingOrderPath).add(order.toJson());

  }

  _deductAvailableItem(Order order, List<MenuItem> menuItemList) async {
    await MenuItemService().deductAvailability(order, menuItemList);
  }
}