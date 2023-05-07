import 'dart:io';

import 'package:doccure_patient/services/fincra_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constant/strings.dart';
import '../model/person/user.dart';

chargeCard(
  BuildContext context,
  PaystackPlugin paystackPlugin,
  String price,
  Function callBack,
) async {
  Charge card = Charge()
    ..amount = int.parse('${double.parse(price).toInt()}00')
    ..reference = _getReference()
    ..email = Hive.box<User>(BoxName).get(USERPATH)!.email;
  CheckoutResponse response = await paystackPlugin.checkout(context, charge: card, method: CheckoutMethod.card);
  if (response.status == true) {
    callBack('success');
  } else {
    callBack('error');
  }
}

String? _getReference() {
  String platform;
  if (Platform.isIOS) {
    platform = 'iOS';
  } else {
    platform = 'Android';
  }
  return 'SkyDoctors_Patient_ChargeFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
}

// chargeWithFincra(String name, String email, BuildContext context) async {
//   final data = await Payment.getCheckoutLink(
//     name: name,
//     email: email,
//   );
//   await Navigator.push(context, CupertinoPageRoute(builder: (_) => PaymentScreen(url: data['link'])));
//   await Future.delayed(const Duration(seconds: 5));
//   final payment = await Payment.verifyPayment(data['reference']);
//   final amount = payment['amount'];
//   final paymentReference = payment['reference'];
//   final merchantReference = payment['merchantReference'];
//   final status = payment['status'];
//   final paymentDate = payment['updatedAt'];
// }
