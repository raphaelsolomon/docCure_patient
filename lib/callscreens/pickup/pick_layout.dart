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
    return (user != null && user!.email != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: user!.email!),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data != null && snapshot.data!.exists) {
                Call call = Call.fromMap(snapshot.data!.data());

                if (!call.hasDialled!) {
                  return PickupScreen(call: call);
                }
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}