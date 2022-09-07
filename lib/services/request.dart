import 'dart:convert';

import 'package:doccure_patient/constanst/strings.dart';
import 'package:http/http.dart' as http;

class ResquestApiServices {
  String ROOTAPI = 'http://localhost:8080/resquest';
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

  void loginRequest(Map<String, String> body) async {
    final res = await http.post(Uri.parse(ROOTAPI),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    if (res.statusCode == 200) {}
  }
}
