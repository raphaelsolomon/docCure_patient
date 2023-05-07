import 'package:doccure_patient/constant/strings.dart';
import 'package:fincra_flutter/fincra_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../services/payment.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  String paymentMethod = 'Paystack';
  final PaystackPlugin paystackPlugin = PaystackPlugin();
  final amountController = TextEditingController();

  @override
  void initState() {
    paystackPlugin.initialize(publicKey: 'pk_test_60dd5a11837171a1a4b168e8587efad49547a848');
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.9,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(
                'Top Up Wallet',
                style: getCustomFont(size: 16.0, color: Colors.black54),
              ),
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.cancel_outlined,
                  size: 20.0,
                  color: Colors.black,
                ))
          ]),
          Divider(),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getCardForm('Enter Amount', ctl: amountController),
              const SizedBox(
                height: 9.0,
              ),
              getDropDownAssurance(),
              const SizedBox(
                height: 20.0,
              ),
              getButton(context, () async {
                if (paymentMethod == 'Paystack' && amountController.text.trim().isNotEmpty) {
                  chargeCard(context, paystackPlugin, amountController.text, (s) {
                    if (s == 'success') {}
                  });
                  return;
                }

                if (paymentMethod == 'Fincra' && amountController.text.trim().isNotEmpty) {
                  FincraFlutter.launchFincra(
                    context,
                    publicKey: "<public_test_key|public_prod_key>",
                    amount: "4000",
                    name: "oyee",
                    phoneNumber: "+2348012345679",
                    currency: "NGN",
                    email: "test@gmail.com",
                    feeBearer: "business",
                    onSuccess: (data) {},
                    onError: (data) {},
                    onClose: () {},
                  );
                }
              }),
              const SizedBox(
                height: 30.0,
              ),
            ]),
          ))
        ],
      ),
    );
  }

  getCardForm(hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: BLUECOLOR.withOpacity(.1)),
        child: TextField(
          controller: ctl,
          style: getCustomFont(size: 14.0, color: Colors.black45),
          maxLines: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 14.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  getDropDownAssurance() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 49.0,
      decoration: BoxDecoration(color: BLUECOLOR.withOpacity(.1), borderRadius: BorderRadius.circular(5.0)),
      child: FormBuilderDropdown<String>(
        name: 'select',
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        onChanged: (value) => paymentMethod = value!,
        decoration: InputDecoration(
          hintText: 'Select Payment Method',
          hintStyle: getCustomFont(size: 13.0, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
        ),
        items: ['Paystack', 'Fincra']
            .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(
                    gender,
                    style: getCustomFont(size: 13.0, color: Colors.black45),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Top Up',
              style: getCustomFont(size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );
}
