import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  Map<String, dynamic> profile = {};

  Call? call;

  User get getUser => _user!;

  setProfile(data) {
    this.profile = data;
    print(data);
  }

  setUser(user) {
    this._user = user;
  }

  setCall(Map<String, dynamic> callUser) {
    this.call = Call.fromMap(callUser);
  }

  Call get getCall => call!;
}
