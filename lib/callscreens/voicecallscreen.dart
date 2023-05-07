// ignore_for_file: unnecessary_string_escapes, deprecated_member_use

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doccure_patient/callscreens/time_view.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class VoiceCallScreen extends StatefulWidget {
  final Call call;

  const VoiceCallScreen({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  VoiceCallScreenState createState() => VoiceCallScreenState();
}

class VoiceCallScreenState extends State<VoiceCallScreen> {
  final CallMethods callMethods = CallMethods();

  UserProvider? userProvider;
  final box = Hive.box<User>(BoxName);
  StreamSubscription? callStreamSubscription;
  late RtcEngine _engine;
  final GlobalKey<TimerViewState> _timerKey = GlobalKey();

  final _infoStrings = <String>[];
  int? remoteID;
  int uid = 0;
  bool _localUserJoined = false;
  bool isMute = false;
  bool _reConnectingRemoteView = false;
  String channelID = "";
  String token = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      token = await generateToken();
      channelID = widget.call.channelId!;
      context.read<UserProvider>().setCall(widget.call.toJson());
      Wakelock.enable(); // Turn on wakelock feature till call is running
      addPostFrameCallback();
      initializeAgora();
    });
  }

  @override
  void dispose() async {
    try {
      await _engine.leaveChannel();
      _engine.release();
      context.read<UserProvider>().setCall({});
    } catch (e) {}
    super.dispose();
  }

  Future<String> generateToken() async {
    final expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;
    final token = RtcTokenBuilder.build(
      appId: APP_ID,
      appCertificate: APP_CERTIFICATE,
      channelName: widget.call.channelId!,
      uid: '${uid}',
      role: RtcRole.publisher,
      expireTimestamp: expireTimestamp,
    );
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: Stack(children: [
          Center(
            child: _remoteVideo(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 110,
                  height: 160,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.grey.shade300, boxShadow: [BoxShadow(color: Colors.grey.shade200, offset: Offset(0.0, 1.0), blurRadius: 5.0, spreadRadius: 1.0)]),
                  child: Center(
                    child: _localUserJoined
                        ? Image.network(
                            widget.call.callerPic!,
                            fit: BoxFit.fill,
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: [
                TimerView((s) {}, key: _timerKey),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        if (!isMute) {
                          _engine.muteLocalAudioStream(true);
                          isMute = true;
                        } else {
                          _engine.muteLocalAudioStream(false);
                          isMute = false;
                        }
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(color: Colors.blue, boxShadow: SHADOW, borderRadius: BorderRadius.circular(100.0)),
                        child: Center(child: Icon(isMute ? Icons.volume_down : Icons.volume_mute_outlined, color: Colors.white, size: 19.0)),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () async {
                        await _engine.leaveChannel();
                        callMethods.endCall(call: widget.call);
                      },
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(color: Colors.redAccent, boxShadow: SHADOW, borderRadius: BorderRadius.circular(100.0)),
                        child: Center(child: Icon(Icons.call_end, color: Colors.white, size: 19.0)),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () => _engine.switchCamera(),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(color: Colors.blue, boxShadow: SHADOW, borderRadius: BorderRadius.circular(100.0)),
                        child: Center(child: Icon(Icons.sync, color: Colors.white, size: 19.0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initRtcEngine();
    var hostbroadcaster = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    );

    await _engine.joinChannel(
      token: token,
      channelId: channelID,
      uid: uid,
      options: hostbroadcaster,
    );
  }

  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      callStreamSubscription = callMethods.callStream(uid: userProvider!.getUser.email!).listen((DocumentSnapshot ds) {
        // defining the logic
        switch (ds.data()) {
          case null:
            // snapshot is null which means that call is hanged and documents are deleted
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });
    });
  }

  Future<void> _initRtcEngine() async {
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: APP_ID));
    await _engine.enableAudio();
    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        final info = 'onJoinChannel: ${connection.channelId}, uid: ${connection.localUid}';
        _infoStrings.add(info);
        _localUserJoined = true;
        mounted ? setState(() {}) : null;
      },
      onError: (err, msg) {
        final info = 'onError: $err';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        final info = 'onUserJoined: $remoteUid';
        _infoStrings.add(info);
        remoteID = remoteUid;
        _timerKey.currentState!.startTimer();
        mounted ? setState(() {}) : null;
      },
      onUserInfoUpdated: (int i, UserInfo userInfo) {
        final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onRejoinChannelSuccess: (connection, elapsed) {
        final info = 'onRejoinChannelSuccess: ${connection.localUid}';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onUserOffline: (RtcConnection connection, uid, elapsed) async {
        if (elapsed == UserOfflineReasonType.userOfflineDropped || elapsed == UserOfflineReasonType.userOfflineQuit) {
          Wakelock.disable();
        }
        callMethods.endCall(call: widget.call);

        final info = 'onUserOffline: a: ${uid}, b: ${elapsed}';
        _infoStrings.add(info);
        remoteID = null;
        _timerKey.currentState?.cancelTimer();
        mounted ? setState(() {}) : null;
      },
      onLocalUserRegistered: (int i, String s) {
        final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onLeaveChannel: (connection, stat) async {
        try {
          await callMethods.endCall(call: widget.call);
        } catch (e) {
          print(e);
        } finally {
          _engine.release();
        }
      },
      onConnectionLost: (c) {
        const info = 'onConnectionLost';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onFirstRemoteVideoFrame: (connection, int uid, int width, int height, int elapsed) {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
        mounted ? setState(() {}) : null;
      },
      onRemoteVideoStats: (connection, remoteVideoStats) {
        if (remoteVideoStats.receivedBitrate == 0) {
          _reConnectingRemoteView = true;
        } else {
          _reConnectingRemoteView = false;
        }
        mounted ? setState(() {}) : null;
      },
      onConnectionStateChanged: (connection, type, reason) async {
        if (type == ConnectionStateType.connectionStateConnected) {
          _reConnectingRemoteView = false;
        } else if (type == ConnectionStateType.connectionStateConnecting) {
          _reConnectingRemoteView = true;
        }
        mounted ? setState(() {}) : null;
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
    ));
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    _engine.release();
    return await callMethods.endCall(call: widget.call);
  }

  Widget _remoteVideo() {
    if (remoteID != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.call.receiverPic!), fit: BoxFit.cover)),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.call.receiverPic!), fit: BoxFit.cover)),
        child: Center(
          child: const Text(
            'Please wait for remote user to join',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      );
    }
  }
}
