import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;
 

}
