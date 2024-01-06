import 'package:e_commerce_app/models/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;
  final List<User> _user = [];

  bool getLogin() {
    return _isLogin;
  }

  void login(User u) {
    if (!(_user.length > 1)) _user.add(u);
    _isLogin = true;
    notifyListeners();
  }

  void logout() {
    // ignore: list_remove_unrelated_type
    _user.clear();
    _isLogin = false;
    notifyListeners();
  }

  User getUser() {
    return _user[0];
  }
}
