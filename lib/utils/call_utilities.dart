import 'dart:math';

import 'package:doccure_patient/callscreens/videocallscreen.dart';
import 'package:doccure_patient/callscreens/voicecallscreen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/user.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:get/get.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial(
      {required User from,
      required User to,
      required bool type,
      context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      type: type,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      call.type!
          ? Get.to(() => VideoCallScreen(call: call))
          : Get.to(() => VoiceCallScreen(call: call));
    }
  }
}
