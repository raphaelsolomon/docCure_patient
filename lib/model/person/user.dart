import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  bool? verified;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? country;
  @HiveField(6)
  String? profilePhoto;
  @HiveField(7)
  String? token;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  String? marital_status;
  @HiveField(10)
  String? dob;
  @HiveField(11)
  String? weight;
  @HiveField(12)
  String? height;
  @HiveField(13)
  String? age;
  @HiveField(14)
  String? cat;
  @HiveField(15)
  String? status;

  User(
      {this.uid,
      this.name,
      this.email,
      this.verified,
      this.phone,
      this.country,
      this.profilePhoto,
      this.token,
      this.gender,
      this.marital_status,
      this.age,
      this.dob,
      this.status,
      this.cat,
      this.height,
      this.weight});

  Map toMap(User user) {
    var data = <String, dynamic>{};
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['verified'] = user.verified;
    data["phone"] = user.phone;
    data["country"] = user.country;
    data["profile_photo"] = user.profilePhoto;
    data["token"] = user.token;
    data["gender"] = user.gender;
    data["marital_status"] = user.marital_status;
    data["dob"] = user.dob;
    data["weight"] = user.weight;
    data["height"] = user.height;
    data["age"] = user.age;
    data["cat"] = user.cat;
    data["status"] = user.status;
    return data;
  }

  // Named constructor
  User.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    name = mapData['name'];
    email = mapData['email'];
    verified = mapData['verified'];
    phone = mapData['phone'];
    country = mapData['country'];
    profilePhoto = mapData['profile_photo'];
    token = mapData['token'];
    gender = mapData['gender'];
    marital_status = mapData['marital_status'];
    age = mapData['age'];
    dob = mapData['dob'];
    status = mapData['status'];
    cat = mapData['cat'];
    height = mapData['height'];
    weight = mapData['weight'];
  }
}
