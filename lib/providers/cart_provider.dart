import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removerTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems;
    notifyListeners();
  }

  String getTptalPriveVND() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return formatCurrency.format(_totalPrice).toString();
  }
  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter() {
    _counter--;
    _setPrefItems;
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
