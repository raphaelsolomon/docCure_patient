// ignore_for_file: unnecessary_string_escapes, deprecated_member_use

import 'dart:async';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtclocalview;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtcremoteview;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  CallScreenState createState() => CallScreenState();
}

class CallScreenState extends State<CallScreen> {
  final CallMethods callMethods = CallMethods();

  UserProvider? userProvider;
  StreamSubscription? callStreamSubscription;
  late RtcEngine _engine;

  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
    initializeAgora();
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
    await _engine.enableWebSdkInteroperability(true);
    await _engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await _engine.joinChannel(null, widget.call.channelId!, null, 0);
  }

  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);

      callStreamSubscription = callMethods
          .callStream(uid: userProvider!.getUser.uid!)
          .listen((DocumentSnapshot ds) {
        // defining the logic
        switch (ds.data()) {
          case Object == null:
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });
    });
  }

  /// Create agora sdk instance and initialize
  Future<void> _initRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    _engine.setEventHandler(RtcEngineEventHandler(error: (err) {
      setState(() {
        final info = 'onError: $err';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (String channel, int uid, int elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, userJoined: (int uid, int elapsed) {
      setState(() {
        final info = 'onUserJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userInfoUpdated: (int i, UserInfo userInfo) {
      setState(() {
        final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
        _infoStrings.add(info);
      });
    }, rejoinChannelSuccess: (String string, int a, int b) {
      setState(() {
        final info = 'onRejoinChannelSuccess: $string';
        _infoStrings.add(info);
      });
    }, userOffline: (int a, b) {
      callMethods.endCall(call: widget.call);
      setState(() {
        final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
        _infoStrings.add(info);
      });
    }, localUserRegistered: (int i, String s) {
      setState(() {
        final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stat) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, connectionLost: () {
      setState(() {
        const info = 'onConnectionLost';
        _infoStrings.add(info);
      });
    }, firstRemoteVideoFrame: (int uid, int width, int height, int elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(const rtclocalview.SurfaceView());
    for (var uid in _users) {
      list.add(rtcremoteview.SurfaceView(uid: uid, channelId: widget.call.channelId!,));
    }
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[_videoView(views[0])],
        );
      case 2:
        return Column(
          children: <Widget>[
        _expandedVideoRow([views[0]]),
        _expandedVideoRow([views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
        _expandedVideoRow(views.sublist(0, 2)),
        _expandedVideoRow(views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
        _expandedVideoRow(views.sublist(0, 2)),
        _expandedVideoRow(views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return const SizedBox();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => callMethods.endCall(
              call: widget.call,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
