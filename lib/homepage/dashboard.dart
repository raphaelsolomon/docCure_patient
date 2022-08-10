import 'package:agora_rtm/agora_rtm.dart';
import 'package:doccure_patient/callscreens/pickup/pick_layout.dart';
import 'package:doccure_patient/chat/msg_log.dart';
import 'package:doccure_patient/chat/msg_screen.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/permission/permissions.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/utils/call_utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AgoraRtmClient? _client;
  LogController logController = LogController();

  @override
  void initState() {
    createClient();
    context.read<UserProvider>().refreshUser(_client);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _client!.logout();
  }

  @override
  Widget build(BuildContext context) {
    var newList = users.where((user) => user.username != 'phoenixk54').toList();
    return PickupLayout(
        userProvider: context.read<UserProvider>(),
        scaffold: Scaffold(
          drawer: null,
          backgroundColor: Colors.red,
          body: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      ...newList
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => MessageScreen(
                                      _client!, logController, e));
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage:
                                                  NetworkImage(e.profilePhoto!),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Flexible(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${e.email}',
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 2.0,
                                                ),
                                                Text(
                                                  '${e.username}',
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black45),
                                                ),
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () async => await Permissions
                                                  .cameraAndMicrophonePermissionsGranted()
                                              ? CallUtils.dial(
                                                  from: context
                                                      .read<UserProvider>()
                                                      .getUser,
                                                  to: e,
                                                  type: false,
                                                  context: context)
                                              : {},
                                          child: const Icon(
                                            Icons.phone_callback,
                                            color: Colors.green,
                                          )),
                                      const SizedBox(
                                        width: 18.0,
                                      ),
                                      GestureDetector(
                                          onTap: () async => await Permissions
                                                  .cameraAndMicrophonePermissionsGranted()
                                              ? CallUtils.dial(
                                                  from: context
                                                      .read<UserProvider>()
                                                      .getUser,
                                                  to: e,
                                                  type: true,
                                                  context: context)
                                              : {},
                                          child: const Icon(
                                            Icons.video_call,
                                            color: Colors.redAccent,
                                            size: 30.0,
                                          )),
                                    ]),
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ))),
        ));
  }

  void createClient() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
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
