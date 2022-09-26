import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/constant/strings.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
    final request = await http.Request('GET', Uri.parse(PATIENT_API));
    request.body = json.encode({
        "url": "http://patient.gettheskydoctors.com"
    });
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    return {};
  }
}
