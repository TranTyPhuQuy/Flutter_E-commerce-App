import 'dart:collection';

import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/foundation.dart';

class Cartt extends ChangeNotifier {
  final Map<int, CartItem> _carts = HashMap();
  final List<CartItem> _list = [];

  void addProduct(Product p) {
    if (_carts.containsKey(p.productId)) {
      _carts[p.productId]?.increaseQuantity();
    } else {
      _carts[p.productId] = CartItem(p, 1);
      _list.add(CartItem(p, 1));
    }
    notifyListeners();
  }

  void removeProduct(Product p) {
    if (_carts.containsKey(p.productId)) {
      _carts[p.productId]?.decreaseQuantity();
    notifyListeners();
    }
  }

  List<CartItem> getCarts() {
    return _list;
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var cartItem in _carts.values) {
      total += cartItem.getPrice();
    }
    return total;
  }

  int getCounter() {
    return _carts.length;
  }
}
