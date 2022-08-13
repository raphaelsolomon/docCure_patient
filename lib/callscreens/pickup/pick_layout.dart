// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doccure_patient/callscreens/pickup/pickup_screen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';

class PickupLayout extends StatelessWidget {
  final User? user;
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    Key? key,
     required this.user,
    required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (user != null && user!.uid != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: user!.uid!),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data != null && snapshot.data!.exists) {
                Call call = Call(
                  callerId: snapshot.data!.get('caller_id'),
                  callerName: snapshot.data!.get('caller_name'),
                  callerPic: snapshot.data!.get('caller_pic'),
                  channelId: snapshot.data!.get('channel_id'),
                  receiverId: snapshot.data!.get('receiver_id'),
                  receiverName: snapshot.data!.get('receiver_name'),
                  receiverPic: snapshot.data!.get('receiver_pic'),
                  hasDialled: snapshot.data!.get('has_dialled'),
                );

                if (!call.hasDialled!) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : scaffold;
  }
}
// const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );