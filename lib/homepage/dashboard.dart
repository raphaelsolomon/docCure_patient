import 'package:agora_rtm/agora_rtm.dart';
import 'package:doccure_patient/callscreens/pickup/pick_layout.dart';
import 'package:doccure_patient/chat/chat_list.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/homepage/appointment.dart';
import 'package:doccure_patient/homepage/doctor_profile.dart';
import 'package:doccure_patient/homepage/find_doctors.dart';
import 'package:doccure_patient/homepage/home.dart';
import 'package:doccure_patient/homepage/invoice.dart';
import 'package:doccure_patient/homepage/patient_profile.dart';
import 'package:doccure_patient/homepage/search_doctor.dart';
import 'package:doccure_patient/homepage/time_and_date.dart';
import 'package:doccure_patient/homepage/vital_and_tracks.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/msg_log.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
 
    return WillPopScope(
      onWillPop: () => context.read<HomeController>().onBackPress(),
      child: PickupLayout(
          user: box.get('details'),
          scaffold: Scaffold(
              key: scaffold,
              drawer: navDrawer(context, scaffold),
              backgroundColor: Colors.white,
              body: page == 0
                  ? FindDoctorsPage(scaffold)
                  : page == 10
                      ? HomePage(scaffold)
                      : page == 1
                          ? VitalAndTracks(scaffold)
                          : page == 4
                              ? MyAppointment(scaffold)
                              : page == 5
                                  ? ChatListScreen(
                                      scaffold, logController, _client)
                                  : page == 6
                                      ? MyInvoicePage(scaffold)
                                      : page == -2
                                          ? MyProfile(scaffold)
                                          : page == -4
                                              ? DoctorProfile(scaffold)
                                              : page == -3
                                                  ? SearchDoctor(scaffold)
                                                  : page == -1
                                                      ? TimeAndDate(scaffold)
                                                      : Container(
                                                          child: Center(
                                                            child: Text(
                                                              'Development Mode..',
                                                              style: getCustomFont(
                                                                  size: 19.0,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ))),
    );
  }

  void createClient() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
    context.read<UserProvider>().refreshUser(_client);
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
