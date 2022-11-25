import 'package:agora_rtm/agora_rtm.dart';
import 'package:doccure_patient/auth/change_password.dart';
import 'package:doccure_patient/callscreens/pickup/pick_layout.dart';
import 'package:doccure_patient/chat/chat_list.dart';
import 'package:doccure_patient/company/account.dart';
import 'package:doccure_patient/company/favourite.dart';
import 'package:doccure_patient/company/invoice_receipt.dart';
import 'package:doccure_patient/company/myoffer.dart';
import 'package:doccure_patient/company/myprescription.dart';
import 'package:doccure_patient/company/myreferral.dart';
import 'package:doccure_patient/company/notification.dart';
import 'package:doccure_patient/company/notificationsetting.dart';
import 'package:doccure_patient/company/profilesettings.dart';
import 'package:doccure_patient/company/rateus.dart';
import 'package:doccure_patient/company/shareapp.dart';
import 'package:doccure_patient/company/socialmedia.dart';
import 'package:doccure_patient/company/support.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/homepage/doctor_profile.dart';
import 'package:doccure_patient/homepage/find_doctors.dart';
import 'package:doccure_patient/homepage/home.dart';
import 'package:doccure_patient/homepage/invoice.dart';
import 'package:doccure_patient/homepage/myfamily.dart';
import 'package:doccure_patient/homepage/new_home_page.dart';
import 'package:doccure_patient/homepage/patient_profile.dart';
import 'package:doccure_patient/homepage/reminder.dart';
import 'package:doccure_patient/homepage/search_doctor.dart';
import 'package:doccure_patient/homepage/time_and_date.dart';
import 'package:doccure_patient/homepage/vital_and_tracks.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/msg_log.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resuable/custom_nav.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AgoraRtmClient? _client;
  LogController logController = LogController();
  final scaffold = GlobalKey<ScaffoldState>();
  final box = Hive.box<User>(BoxName);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (box.get(USERPATH) != null) {
        final response = await ApiServices.getProfile(box.get(USERPATH)!.token);
        context.read<UserProvider>().setProfile(response);
      }
      dialogMessage(context, subscribe(context));
      createClient();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _client!.logout();
  }

  @override
  Widget build(BuildContext context) {
    final page = context.watch<HomeController>().getPage;
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) => WillPopScope(
        onWillPop: () => context.read<HomeController>().onBackPress(),
        child: PickupLayout(
            user: box.get('details'),
            scaffold: Scaffold(
                key: scaffold,
                drawer: !removeBottom.contains(page) ? navDrawer(context, scaffold, box) : null,
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    page == 0
                        ? AllHomePage(scaffold)
                        : page == 10
                            ? HomePage(scaffold)
                            : page == 12 //no bottom nav
                                ? NotificationPage()
                                : page == 1 //no bottom nav
                                    ? VitalAndTracks(scaffold)
                                    : page == 5
                                        ? ChatListScreen(scaffold, logController, _client)
                                        : page == 6
                                            ? MyInvoicePage()
                                            : page == 7 //no bottom nav
                                                ? MyFamily()
                                                : page == 8 //no bottom nav
                                                    ? MyReminder()
                                                    : page == 9 //no bottom nav
                                                        ? MyReferrals()
                                                        : page == -4 //no bottom nav
                                                            ? DoctorProfile(scaffold)
                                                            : page == -5 //no bottom nav
                                                                ? NotificationSettingsPage()
                                                                : page == -6 //no bottom nav
                                                                    ? RateUS()
                                                                    : page == -7 //no bottom nav
                                                                        ? ShareApp()
                                                                        : page == -8 //no bottom nav
                                                                            ? AuthChangePass()
                                                                            : page == -9 //no bottom nav
                                                                                ? SupportPage()
                                                                                : page == -10
                                                                                    ? MyProfile(scaffold)
                                                                                    : page == -11
                                                                                        ? Prescriptions(scaffold)
                                                                                        : page == -12 //no bottom nav
                                                                                            ? MyOffer()
                                                                                            : page == -17 ? MyFavourite() : page == -3
                                                                                                ? SearchDoctor(scaffold)
                                                                                                : page == -1 //no bottom nav
                                                                                                    ? TimeAndDate(scaffold)
                                                                                                    : page == -2 //no bottom nav
                                                                                                       // ? ProfileSettings(scaffold)
                                                                                                       ? ProfileSettings(scaffold)
                                                                                                        : page == -14
                                                                                                            ? InvoiceReceipt(scaffold)
                                                                                                            : page == -16
                                                                                                                ? FindDoctorsPage(scaffold)
                                                                                                                : page ==-13 
                                                                                                                    ? SocialMedia(scaffold)
                                                                                                                    : AccountPage(),
                    !isVisible &&
                            (!removeBottom.contains(page) &&
                                !removeBottom1.contains(page))
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomNavBar(
                              context,
                              pageIndex: 0,
                            ))
                        : SizedBox()
                  ],
                ))),
      ),
    );
  }

  void createClient() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
    //_client!.login(null, box.get(USERPATH)!.uid!);
    _client!.login(null, 'darkseid');
    _client!.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      logController.addLog("Private Message from $peerId: ${message.text}");
    };
    _client!.onConnectionStateChanged = (int state, int reason) {
      if (kDebugMode) {
        print('Connection state changed: $state, reason: $reason');
      }
      if (state == 5) {
        _client!.logout();
        if (kDebugMode) {
          print('Logout.');
        }
      }
    };
  }
}
