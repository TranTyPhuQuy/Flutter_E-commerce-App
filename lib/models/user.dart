import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  // ignore: unused_field
  final int _userId;
  String userName;
  String email;
  int roleId;

  User( this._userId, this.userName, this.email, this.roleId);


}
