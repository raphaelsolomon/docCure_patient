import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/auth/onboarding.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_form_field/l10n/generated/phone_field_localization.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up : ${message.messageId}');
  print('A bg message just showed up : ${message.messageType}');
  print('A bg message just showed up : ${message.data}');
}

//key ID W3GQWWTG35
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  await [Permission.microphone, Permission.camera].request();
  ErrorWidget.builder = ((details) => Material(
        child: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                details.exceptionAsString(),
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ));
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(BoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Box<User> box = Hive.box<User>(BoxName);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
      ],
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          PhoneFieldLocalization.delegate
        ],
        locale: Locale('en', ''),
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        title: 'DocCure Patient',
        defaultTransition: Transition.zoom,
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
            primaryColor: Colors.black54),
        home: box.get('first') == null
            ? const OnBoardingScreen()
            : const AuthLogin(),
      ),
    );
  }
}
