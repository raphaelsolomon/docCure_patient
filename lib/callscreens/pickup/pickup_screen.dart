import 'dart:ui';

import 'package:doccure_patient/callscreens/videocallscreen.dart';
import 'package:doccure_patient/callscreens/voicecallscreen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/permission/permissions.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage(call.callerPic!),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low)),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Incoming...",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(300.0)),
                child: Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.2),
                        borderRadius: BorderRadius.circular(300.0)),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(call.callerPic!),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low),
                            borderRadius: BorderRadius.circular(100.0)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                call.callerName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 75),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.call_end),
                    color: Colors.redAccent,
                    onPressed: () async {
                      await callMethods.endCall(call: call);
                    },
                  ),
                  const SizedBox(width: 25),
                  IconButton(
                    icon: const Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () async => await Permissions
                            .cameraAndMicrophonePermissionsGranted()
                        ? call.type!
                            ? Get.to(() => VideoCallScreen(call: call))
                            : Get.to(() => VoiceCallScreen(call: call))
                        : {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
