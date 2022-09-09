import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:http/http.dart' as http;


const String ROOTAPI = 'https://api.gettheskydoctors.com';


class ResquestApiServices {
  
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
}
