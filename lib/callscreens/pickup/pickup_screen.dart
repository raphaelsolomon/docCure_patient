import 'package:doccure_patient/callscreens/callscreen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/permission/permissions.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:doccure_patient/widgets/cacheimage.dart';
import 'package:flutter/material.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({Key? key, 
    required this.call,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Incoming...",
              style:  TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            CachedImage(
              call.callerPic!,
              isRound: true,
              radius: 180,
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
                  onPressed: () async =>
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallScreen(call: call),
                              ),
                            )
                          : {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}