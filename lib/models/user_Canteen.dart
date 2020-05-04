import 'package:jiitexpense/models/order.dart';

class UserCanteen {
  String uid;
  double balance;
  List<Order> orders;

  UserCanteen({this.uid, this.balance, this.orders});
}