import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/auth/onboarding.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/firebase_options.dart';
import 'package:doccure_patient/homepage/dashboard.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/notification/helper_notification.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phone_form_field/l10n/generated/phone_field_localization.dart';
import 'package:provider/provider.dart';

bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('A bg message just showed up : ${message.messageId}');
}

// key ID W3GQWWTG35
// 4M5F6CFH72
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'patient',
    options: DefaultFirebaseOptions.currentPlatform);
  final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    print(remoteMessage);
  }
  await HelperNotification.initialize();
  HelperNotification.onNotification.stream.listen(onClickedEvent);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(BoxName);
  await Hive.openBox('Initialization');
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
}

void onClickedEvent(String? payload) {}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final box = Hive.box('Initialization');
  final Box<User> user = Hive.box<User>(BoxName);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: 'Patient',
        defaultTransition: Transition.zoom,
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
            primaryColor: Colors.black54),
        home: box.get('isFirst') == null
            ? const OnBoardingScreen()
            : user.get(USERPATH) == null
                ? const AuthLogin()
                : DashBoard(),
      ),
    );
  }
}
