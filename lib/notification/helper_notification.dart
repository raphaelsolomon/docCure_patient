
import 'package:doccure_patient/services/request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HelperNotification {
  static Future<void> initialize(FlutterLocalNotificationsPlugin plugin) async {
    var androidInitializer = AndroidInitializationSettings('ic_launcher');
    var iosInitializer = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializer, iOS: iosInitializer);

    plugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
          print(payload);
        }
      } catch (e) {
        print(e);
      }
      return;
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print('===========onMessage===================');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {});
  }

  showNotification() async {
    final largeIcon =
        await RequestApiServices.downloadFile('url', DateTime.now().toString());
    final styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(''),
        largeIcon: FilePathAndroidBitmap(largeIcon));

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id_gettheskydoctors',
        'channel name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        enableVibration: true,
      ),
      iOS: IOSNotificationDetails()
    );
  }
}
