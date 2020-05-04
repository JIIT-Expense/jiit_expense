import 'dart:collection';

import 'package:jiitexpense/models/menu_item.dart';

class Cart {
  HashMap menuItemWithQuantity = HashMap<MenuItem, int>();

  updateQuantity(MenuItem menuItem, int quantity) {
    print(this.menuItemWithQuantity);
    if (quantity == 0 && this.menuItemWithQuantity.containsKey(menuItem)) {
      this.menuItemWithQuantity.remove(menuItem);
    } else {
      this.menuItemWithQuantity[menuItem] = quantity;
    }
  }

  double getTotal() {
    double total = 0;
    this.menuItemWithQuantity.forEach((menuItem, quantity) => {
      total += menuItem.price * quantity
    });
    return total;
  }

}