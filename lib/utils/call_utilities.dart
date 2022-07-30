import 'dart:math';

import 'package:doccure_patient/callscreens/callscreen.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/log.dart';
import 'package:doccure_patient/model/user.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:doccure_patient/utils/local_db.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({required User from, required User to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    Log log = Log(
      callerName: from.name!,
      callerPic: from.profilePhoto!,
      callStatus: CALL_STATUS_DIALLED,
      receiverName: to.name!,
      receiverPic: to.profilePhoto!,
      timestamp: DateTime.now().toString()
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      // enter log
      LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }
}