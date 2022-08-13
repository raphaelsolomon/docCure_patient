import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  List<int> index = [0];

  setPage(value) {
    this.index.add(value);
    notifyListeners();
  }

  Future<bool> onBackPress() async {
    if (index.last == 0) {
      return true;
    } else {
      index.removeLast();
      notifyListeners();
      return false;
    }
  }

  jumpToHome() {
    index.clear();
    index.add(0);
    notifyListeners();
  }

  int get getPage => index.last;
}
