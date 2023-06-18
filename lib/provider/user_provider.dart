import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methord.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethord _authMethord = AuthMethord();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethord.getUserDetail();

    _user = user;
    notifyListeners();
  }
}
