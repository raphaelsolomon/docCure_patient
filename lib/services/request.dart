import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;

const String ROOTAPI = 'https://api.gettheskydoctors.com';
const String PATIENT_API = "http://patient.gettheskydoctors.com";

class ApiServices {
  String GOOGLEAPI = 'https://fcm.googleapis.com/fcm/send';

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
    final request = await http.Request('GET', Uri.parse(ROOTAPI));
    request.body = json.encode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    return {};
  }

  static Future<void> changePassword(BuildContext c, token, oldPass, newPass) async {
    var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/patient/change-password'));
    request.body = '''{\n    "url": "http://patient.gettheskydoctors.com",\n    "old_password": "${oldPass}",\n    "new_password": "${newPass}"\n}''';
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
        popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future<void> updateProfile(BuildContext c, token, body) async {
    var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/v1/auth/patient/update-profile'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Uchiha Madara"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
        popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //================================ MEDICAL RECORD SET =================================
  static Future<Map<String, dynamic>> getAllMedicalRecords(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/patient/all-medical-records'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return parsed;
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
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
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

   //================================ DEPENDENTS =================================
   static Future<Map<String, dynamic>> getAllDepends(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/all-dependents'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return parsed;
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
      return {};
    }
  }

  static Future addDependents(BuildContext c, token) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/add-dependent'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "John Doe", "picture": "test-picure", "relationship": "test-relationship", "gender": "test-gender", "number": "34567890", "bloodgroup": "A+"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future deleteDependent(BuildContext c, token, id) async {
    var request = http.Request('DELETE', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/delete-dependent/${id}'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future updateDependent(BuildContext c, token, id) async {
    var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/v1/auth/patient/dependents/edit-dependent/${id}'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Uchiha Itachi"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  //================================ MEDICAL OTHER RECORD SET =================================
  static Future<Map<String, dynamic>> getAllOtherMedicalRecords(BuildContext c, token) async {
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/all'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return parsed;
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
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
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future updateOtherMedicalRecord(BuildContext c, token, id) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/edit/${id}'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com", "name": "Test", "bmi": "", "heart_rate": "", "fbc_status": "", "weight": ""});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }

  static Future deleteOtherMedicalRecord(BuildContext c, token, id) async {
    var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/delete/${id}'));
    request.body = jsonEncode({"url": "http://patient.gettheskydoctors.com"});
    request.headers.addAll({'Authorization': 'Bearer $token', 'Content-Type': 'application/json'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       final parsed = jsonDecode(await response.stream.bytesToString());
       return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['success']['message'], status: true));
    } else {
      final parsed = jsonDecode(await response.stream.bytesToString());
      return popupMessage.dialogMessage(c,  popupMessage.serviceMessage(c, parsed['error']['message'], status: false));
    }
  }
}
