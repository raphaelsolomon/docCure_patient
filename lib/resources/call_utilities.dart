import 'dart:math';

import 'package:doccure_patient/callscreens/videocallscreen.dart';
import 'package:doccure_patient/callscreens/voicecallscreen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial(BuildContext context, {required User from, required User to, isVideo = true}) async {
    Call call = Call(
      callerId: from.email,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.email,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000).toString()}',
      type: isVideo,
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isVideo ? VideoCallScreen(call: call) : VoiceCallScreen(call: call),
          ));
    }
  }
}
