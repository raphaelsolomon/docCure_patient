import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  Map<String, dynamic> profile = {};

  User get getUser => _user!;

  setProfile(data) {
    this.profile = data;
    print(data);
  }
}
