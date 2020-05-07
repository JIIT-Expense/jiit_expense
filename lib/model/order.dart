import 'package:jiitexpense/model/menuItem.dart';

class Order {
  final List<MenuItem> items;
  final double totalAmount;
  final int totalEstimatedTime;
  final String userId;

  Order({this.items, this.totalAmount, this.totalEstimatedTime, this.userId});

}