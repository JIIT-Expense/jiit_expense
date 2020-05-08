import 'package:jiitexpense/model/menuItem.dart';

class MenuItemWithQuantity extends MenuItem {
  final int quantity;

  MenuItemWithQuantity({name, availability, cost, waitingTime, this.quantity}) : super(name: name, availability: availability, cost: cost, waitingTime: waitingTime);
}