import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/agora_reg.model.dart';
import 'package:doccure_patient/model/prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;
import 'package:pull_to_refresh/pull_to_refresh.dart';

const String ROOTAPI = 'https://api.gettheskydoctors.com';

const String ROOTAGORA = 'https://a71.chat.agora.io/${AGORA_ORGNAME}/${AGORA_APPNAME}/users';

class ApiServices {
  String GOOGLEAPI = 'https://fcm.googleapis.com/fcm/send';

  static Future<AgoraRegUser> getreguser(token, Map<String, String> body) async {
    late AgoraRegUser agoraRegUser;
    final res = await http.Client().post(Uri.parse(ROOTAGORA), body: body, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}',
    });
    if (res.statusCode == 200) {
      agoraRegUser = AgoraRegUserFromJson(res.body);
    }
    return agoraRegUser;
  }

  static Future<String> getAppToken() async {
    late String agoraRegUser = '';
    final res = await http.Client().get(Uri.parse('http://192.168.8.102:3000/api/v1/appToken'));
    if (res.statusCode == 200) {
      agoraRegUser = jsonDecode(res.body)['token'];
    }
    return agoraRegUser;
  }

  static Future<String> getChatUserToken(String userID) async {
    late String agoraRegUser = '';
    final res = await http.Client().get(Uri.parse('http://192.168.8.102:3000/api/v1/user-token/${userID}'));
    if (res.statusCode == 200) {
      agoraRegUser = jsonDecode(res.body)['token'];
      print(agoraRegUser);
    }
    return agoraRegUser;
  }

  void sendNotification(token) async {
    final res = await http.post(Uri.parse(GOOGLEAPI), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=${FIREBASE_WEB_TOKEN}'
    }, body: {
      'to': token,
      'priority': 'high',
      'notification': jsonEncode({
        'title': 'Notification',
        'body': 'Notification body',
      })
    });
    if (res.statusCode == 200) {}
  }

  static Future<String> downloadFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$filename';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<Map<String, dynamic>> getProfile(token) async {
    final response = await http.Client().get(Uri.parse('${ROOTAPI}/api/v1/auth/patient/profile'), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed;
    }
    return {};
  }

  static Future<void> updateProfile(BuildContext c, token, body) async {
    var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/v1/auth/patient/update-profile'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Uchiha Madara"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //================================ MEDICAL RECORD SET =================================
  static Future<Map<String, dynamic>> getAllMedicalRecords(RefreshController controller, BuildContext c, box) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/records/all-medical-records'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        return jsonDecode(value);
      });
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
      return {};
    }
  }

  static Future addMedicalRecord(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/add-medical-record'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "", "date": "", "description": "", "attachment": "", "ordered_by": ""});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //================================ DEPENDENTS =================================
  static Future<Map<String, dynamic>> getAllDepends(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/dependents/all-dependents'));
    request.headers.addAll({'Authorization': '$token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        return jsonDecode(value);
      });
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
      return {};
    }
  }

  static Future addDependents(BuildContext c, token) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/dependents/add-dependent'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "John Doe", "picture": "test-picure", "relationship": "test-relationship", "gender": "test-gender", "number": "34567890", "bloodgroup": "A+"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future deleteDependent(BuildContext c, token, id, callBack) async {
    callBack();
    var request = http.Request('DELETE', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/delete-dependent/${id}'));
    request.headers.addAll({'Authorization': '$token'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        callBack();
        final parsed = jsonDecode(value);
        return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['message'], status: true));
      });
    } else {
      return response.stream.bytesToString().then((value) {
        return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, jsonDecode(value)['message'], status: false));
      });
    }
  }

  static Future updateDependent(BuildContext c, token, id) async {
    var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/edit-dependent/${id}'));
    request.headers.addAll({'Authorization': '$token'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, jsonDecode(value)['success']['message'], status: true));
      });
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //================================ MEDICAL OTHER RECORD SET =================================
  static Future<Map<String, dynamic>> getAllOtherMedicalRecords(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/all'));
    request.headers.addAll({'Authorization': '$token'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        return jsonDecode(value);
      });
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
      return {};
    }
  }

  static Future addOtherMedicalRecord(BuildContext c, token) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/add-other-medical-record'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Test", "bmi": "", "heart_rate": "", "fbc_status": "", "weight": ""});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future updateOtherMedicalRecord(BuildContext c, token, id) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/edit/${id}'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Test", "bmi": "", "heart_rate": "", "fbc_status": "", "weight": ""});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future deleteOtherMedicalRecord(BuildContext c, token, id, callBack) async {
    callBack();
    var request = http.Request('DELETE', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/delete/${id}'));
    request.headers.addAll({'Authorization': '$token'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString().then((value) {
        callBack();
        return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, jsonDecode(value)['message'], status: true));
      });
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c, popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //======================================PRESCRIPTION================================================================
  static Future<PrescriptionModel> getPrescriptions(RefreshController controller, box) async {
    PrescriptionModel model = new PrescriptionModel();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/prescriptions/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return model = PrescriptionModel.fromJson(jsonDecode(value));
      });
    }
    controller.refreshFailed();
    return model;
  }

  static Future<Map<String, dynamic>> getAppointments(RefreshController controller, box) async {
    var result = Map<String, dynamic>();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/appointment/view'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return result = jsonDecode(value);
      });
    }
    controller.refreshFailed();
    return result;
  }

  static Future<Map<String, dynamic>> getFavouriteDocs(RefreshController controller, box) async {
    var result = Map<String, dynamic>();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/favorites/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return result = jsonDecode(value);
      });
    }
    controller.refreshFailed();
    return result;
  }

  static Future<Map<String, dynamic>> getFavouriteDocProfile(RefreshController controller, box, String id) async {
    var result = Map<String, dynamic>();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/favorites/view/${id}'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return result = jsonDecode(value);
      });
    }
    controller.refreshFailed();
    return result;
  }

  static Future<void> changePatientImage(BuildContext context, String file, box) async {
    var request = http.MultipartRequest('POST', Uri.parse('${ROOTAPI}/api/v1/users/image/upload'));
    request.files.add(await http.MultipartFile.fromPath('profile_image', '${file}'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      final parsed = jsonDecode(result);
      box.get(USERPATH)!.profilePhoto = parsed['data']['image_url'];
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, parsed['message'], status: true));
    } else {
      print(response.reasonPhrase);
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
    }
  }
}
