import 'package:doccure_patient/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  void refreshUser() async {
    User user = User(
        email: 'phoenixk54@gmail.com',
        name: 'Uzoechi chigozie',
        uid: 'darkseidjdbjsbkjv',
        username: 'phoenixk54',
        profilePhoto: 'https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg',
        status: 'Online',
        state: 1);
    _user = user;
    notifyListeners();
  }
}
