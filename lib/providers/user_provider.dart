import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;
 
  void refreshUser(client) async {
   User user = User(
        email: 'phoenixk54@gmail.com',
        name: 'Uzoechi chigozie',
        uid: 'darkseidjdbjsbkjv',
        username: 'phoenixk54',
        profilePhoto:
            'https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg',
        status: 'Online',
        state: 1);

    // User user = User(
    //     email: 'phoenixk545@gmail.com',
    //     name: 'Uchiha Madara',
    //     uid: 'phoenixk5weufuhieh',
    //     username: 'phoenixk545',
    //     profilePhoto:
    //         'https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg',
    //     status: 'Online',
    //     state: 1);
    _user = user;
     await client!.login(null, user.uid!);
  }
}
