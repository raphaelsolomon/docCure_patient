import 'dart:io';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/auth/onboarding.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/firebase_options.dart';
import 'package:doccure_patient/homepage/dashboard.dart';
import 'package:doccure_patient/model/message/message.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/notification/helper_notification.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  Platform.isIOS ? await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform) : await Firebase.initializeApp(name: 'patient', options: DefaultFirebaseOptions.currentPlatform);

  await HelperNotification.initialize();

  HelperNotification.onNotification.stream.listen(onClickedEvent);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(UserAdapter())
    ..registerAdapter(MessageModelAdapter());

  await Hive.openBox<User>(BoxName);
  await Hive.openBox(ReferralBox);
  await Hive.openBox(BOXMESSAGEBOX);

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ErrorWidget.builder = (details) => Material(
        child: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                details.exceptionAsString(),
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.white),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
}

Future<void> onRefreshToken() async {
  FirebaseMessaging.instance.getToken().then((fcmToken) async {
    if (fcmToken != null) {
      try {
        if (Platform.isIOS) {
          await ChatClient.getInstance.pushManager.updateAPNsDeviceToken(fcmToken);
        } else if (Platform.isAndroid) {
          await ChatClient.getInstance.pushManager.updateFCMPushToken(fcmToken);
        }
      } on ChatError catch (e) {
        debugPrint("bind fcm token error: ${e.code}, desc: ${e.description}");
      }
    }
  });
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    try {
      if (Platform.isIOS) {
        await ChatClient.getInstance.pushManager.updateAPNsDeviceToken(newToken);
      } else if (Platform.isAndroid) {
        await ChatClient.getInstance.pushManager.updateFCMPushToken(newToken);
      }
    } on ChatError catch (e) {
      debugPrint("bind fcm token error: ${e.code}, desc: ${e.description}");
    }
  });
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
  String running = '';

  @override
  void initState() {
    ApiServices.getAppToken().then((value) {
      setState(() {
        if (value.isNotEmpty)
          box.put(BOXAGORATOKEN, value);
        else
          running = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
      ],
      child: RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => MaterialClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: GetMaterialApp(
          // localizationsDelegates: const [RefreshLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate, PhoneFieldLocalization.delegate],
          // locale: Locale('en'),
          // supportedLocales: const [
          //   const Locale('en'),
          //   const Locale('zh'),
          //   const Locale('ja'),
          //   const Locale('uk'),
          //   const Locale('it'),
          //   const Locale('ru'),
          //   const Locale('fr'),
          //   const Locale('es'),
          //   const Locale('nl'),
          //   const Locale('sv'),
          //   const Locale('pt'),
          //   const Locale('ko'),
          // ],
          // localeListResolutionCallback: (locales, supportedLocales) {
          //   return locales!.first;
          // },
          title: 'Patient',
          defaultTransition: Transition.zoom,
          debugShowCheckedModeBanner: true,
          builder: (context, child) => ScrollConfiguration(
            child: child!,
            behavior: ScrollBehavior(),
          ),
          theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity, primarySwatch: Colors.blue, primaryColor: Colors.black54),
          home: box.get('isFirst') == null
              ? const OnBoardingScreen()
              : user.get(USERPATH) == null
                  ? const AuthLogin()
                  : DashBoard(),
        ),
      ),
    );
  }
}
