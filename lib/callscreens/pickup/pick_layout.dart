// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doccure_patient/callscreens/pickup/pickup_screen.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    Key? key,
    required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid!),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                Call call = Call(
                  callerId: snapshot.data!.get('callerID'),
                  callerName: snapshot.data!.get('callerName'),
                  callerPic: snapshot.data!.get('callerPic'),
                  channelId: snapshot.data!.get('channelId'),
                  receiverId: snapshot.data!.get('receiverId'),
                  receiverName: snapshot.data!.get('receiverName'),
                  receiverPic: snapshot.data!.get('receiverPic'),
                  hasDialled: snapshot.data!.get('hasDialled'),
                );

                if (!call.hasDialled!) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
