import 'package:flutter/material.dart';

class LoadingController with ChangeNotifier {
  bool bloodPressure = false;
  bool weightLoader = false;
  bool cholesterolLoader = false;
  bool bloodSugarLoader = false;
  String index = "Overview";

  setBloodPressureValue(bool value) {
    this.bloodPressure = value;
    notifyListeners();
  }

  sweWeightLoader(bool value) {
    this.weightLoader = value;
    notifyListeners();
  }

  setCholesterolLoader(bool value) {
    this.cholesterolLoader = value;
    notifyListeners();
  }

  setBloodSugarLoader(bool value) {
    this.bloodSugarLoader = value;
    notifyListeners();
  }

  setProfileIndex({String value = 'Overview'}) {
    this.index = value;
  }
}
