import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
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
  String? city;
  @HiveField(9)
  String? state;
  @HiveField(10)
  String? dob;
  @HiveField(11)
  String? gender;
  @HiveField(12)
  String? address;
  @HiveField(13)
  String? google_id;
  @HiveField(14)
  String? created_at;
  @HiveField(15)
  bool? onboarded;
  @HiveField(16)
  String? zip_code;
  @HiveField(17)
  String? bloodgroup;
  @HiveField(18)
  String? weight;
  @HiveField(19)
  String? height;
  @HiveField(20)
  String? facebook_id;
  @HiveField(21)
  String? about_me;

  User(
      {this.uid,
      this.name,
      this.email,
      this.verified,
      this.phone,
      this.country,
      this.profilePhoto,
      this.token,
      this.city,
      this.state,
      this.gender,
      this.dob,
      this.address,
      this.google_id,
      this.created_at,
      this.bloodgroup,
      this.zip_code,
      this.weight,
      this.height,
      this.facebook_id,
      this.about_me,
      this.onboarded});

  Map toMap(User user) {
    var data = <String, dynamic>{};
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['is_verified'] = user.verified;
    data["phone"] = user.phone;
    data["country"] = user.country;
    data["profile_picture"] = user.profilePhoto;
    data["token"] = user.token;
    data["city"] = user.city;
    data["state"] = user.state;
    data["google_id"] = user.google_id;
    data["address"] = user.address;
    data["user_type"] = user.gender;
    data["created_at"] = user.created_at;
    data["dob"] = user.dob;
    data['onboarded'] = user.onboarded;
    data["zip_code"] = user.zip_code;
    data['bloodgroup'] = user.bloodgroup;
    data['weight'] = user.weight;
    data['height'] = user.height;
    data['about_me'] = user.about_me;
    data['facebook_id'] = user.facebook_id;
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
    profilePhoto = mapData['profile_picture'];
    token = mapData['token'];
    city = mapData['city'];
    state = mapData['state'];
    gender = mapData['gender'];
    dob = mapData['dob'];
    address = mapData['address'];
    google_id = mapData['google_id'];
    created_at = mapData['created_at'];
    onboarded = mapData['onboarded'];
    bloodgroup = mapData['bloodgroup'];
    zip_code = mapData['zip_code'];
    facebook_id = mapData['facebook_id'];
    weight = mapData['weight'];
    about_me = mapData['about_me'];
    height = mapData['height'];
  }
}
