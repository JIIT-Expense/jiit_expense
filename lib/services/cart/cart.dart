import 'package:flutter/material.dart';

class CartBloc with ChangeNotifier {
  Map<int, int> _cart = {};

  Map<int, int> get cart => _cart;

  void addToCart(index, quantity) {
    if (quantity == 0) {
      cart.remove(index);
    } else {
      cart[index] = quantity;
    }
    notifyListeners();
  }

  void clear(index) {
    if (_cart.containsKey(index)) {
      _cart.remove(index);
      notifyListeners();
    }
  }

  int getSize() {
    return cart.length;
  }

}