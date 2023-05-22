import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resuable/stepper.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  String paymentMethod = 'Paystack';
  final PaystackPlugin paystackPlugin = PaystackPlugin();
  final amountController = TextEditingController();
  String amount = '0.00';
  int currentStep = 1;
  int stepLength = 3;

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
      height: MediaQuery.of(context).size.height / 1.4,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            child: NumberStepper(
              totalSteps: stepLength,
              width: MediaQuery.of(context).size.width,
              curStep: currentStep,
              stepCompleteColor: Colors.green,
              currentStepColor: Colors.orange,
              inactiveColor: Colors.white,
              lineWidth: 1.0,
              text: ['Details', 'Confirmation', 'Success'],
              callBack: (i) => setState(() => currentStep = i + 1),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          currentStep == 1
              ? getFormPage()
              : currentStep == 2
                  ? getConfirmation()
                  : getSuccess()
        ],
      ),
    );
  }

  getFormPage() {
    return Expanded(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              null,
              color: BLUECOLOR,
            ),
            Flexible(
              child: Text(
                'Deposit Money',
                style: getCustomFont(size: 18.0, color: Colors.black87, weight: FontWeight.normal, letterSpacing: 1.2),
              ),
            ),
            Icon(
              null,
              size: 20.0,
              color: Colors.black,
            )
          ]),
          Divider(),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30.0,
              ),
              getCardForm('Enter Amount', '10,000,00', ctl: amountController, visible: true),
              const SizedBox(
                height: 15.0,
              ),
              getDropDownAssurance('Payment Method'),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      'Transactions fees',
                      style: GoogleFonts.lato(color: Colors.black54, fontSize: 11.0, height: 1.4, fontWeight: FontWeight.w400),
                    )),
                    Row(
                      children: [
                        Text(
                          '-1.00 USD',
                          style: GoogleFonts.lato(color: Colors.black54, fontSize: 11.0, height: 1.4, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                            decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              'Free',
                              style: GoogleFonts.lato(color: Colors.white, fontSize: 11.0, height: 1.4, fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          'You\'ll Deposit',
                          style: GoogleFonts.lato(color: Colors.black, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w800, letterSpacing: 1.2),
                        )),
                    Text(
                      amount.isEmpty ? '0.00' : '${amount} USD',
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                    ),
                    const SizedBox(width: 10.0)
                  ],
                ),
              ),
              const Spacer(),
              getButton(context, () async {
                setState(() {
                  currentStep = 2;
                });
                // if (paymentMethod == 'Paystack' && amountController.text.trim().isNotEmpty) {
                //   chargeCard(context, paystackPlugin, amountController.text, (s) {
                //     if (s == 'success') {}
                //   });
                //   return;
                // }

                // if (paymentMethod == 'Fincra' && amountController.text.trim().isNotEmpty) {
                //   FincraFlutter.launchFincra(
                //     context,
                //     publicKey: "<public_test_key|public_prod_key>",
                //     amount: "4000",
                //     name: "oyee",
                //     phoneNumber: "+2348012345679",
                //     currency: "NGN",
                //     email: "test@gmail.com",
                //     feeBearer: "business",
                //     onSuccess: (data) {},
                //     onError: (data) {},
                //     onClose: () {},
                //   );
                // }
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

  getCardForm(hint, label, {ctl, visible = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black87, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w500, letterSpacing: 1.2),
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 45.0,
            decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                visible
                    ? Container(
                        width: 90,
                        decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0))),
                        child: Center(
                          child: FormBuilderDropdown<String>(
                            name: 'select',
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                            ),
                            onChanged: (value) => paymentMethod = value!,
                            decoration: InputDecoration(
                              hintText: 'NGN',
                              hintStyle: getCustomFont(size: 13.0, color: Colors.black54, letterSpacing: 1.2, weight: FontWeight.w500),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10.9, vertical: 5.0),
                              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
                            ),
                            items: ['AUD', 'EUR', 'NGN', 'JPY']
                                .map((gender) => DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(
                                        gender,
                                        style: getCustomFont(size: 13.0, color: Colors.black54),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: ctl,
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                    onChanged: (value) => setState(() => amount = value),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: label, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 13.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getDropDownAssurance(hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black87, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w500, letterSpacing: 1.2),
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 45.0,
          decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
          child: FormBuilderDropdown<String>(
            name: 'select',
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            onChanged: (value) => paymentMethod = value!,
            decoration: InputDecoration(
              hintText: 'Select Bank',
              hintStyle: getCustomFont(size: 13.0, color: Colors.black45),
              contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
            ),
            items: ['Paystack', 'Fincra']
                .map((gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(
                        gender,
                        style: getCustomFont(size: 13.0, color: Colors.black87, letterSpacing: 1.2),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget getButton(context, callBack, {text = 'Continue'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 48.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(7.0)),
          child: Center(
            child: Text(
              '$text',
              style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.normal, letterSpacing: 1.2),
            ),
          ),
        ),
      );

  Widget getConfirmation() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              null,
              color: BLUECOLOR,
            ),
            Flexible(
              child: Text(
                'Deposit Money',
                style: getCustomFont(size: 18.0, color: Colors.black87, weight: FontWeight.normal, letterSpacing: 1.2),
              ),
            ),
            Icon(
              null,
              size: 20.0,
              color: Colors.black,
            )
          ]),
          Divider(),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Deposit Money Via', style: getCustomFont(size: 13.0, color: Colors.black87, weight: FontWeight.w600, letterSpacing: 1.2)),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Divider(),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                getDropDownAssurance('Bank'),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), color: Colors.lightBlueAccent.shade100.withOpacity(.4)),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Account Name: ', style: getCustomFont(size: 9.0, color: Colors.black54, letterSpacing: 1.2)),
                          Text('Smith Rhodes', style: getCustomFont(size: 11.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Account Number: ', style: getCustomFont(size: 9.0, color: Colors.black54, letterSpacing: 1.2)),
                          Text('XXXXXX9023', style: getCustomFont(size: 11.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Bank Name: ', style: getCustomFont(size: 9.0, color: Colors.black54, letterSpacing: 1.2)),
                          Text('HDFC Bank', style: getCustomFont(size: 11.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Details', style: getCustomFont(size: 13.0, color: Colors.black87, weight: FontWeight.w600, letterSpacing: 1.2)),
                ),
                const SizedBox(height: 10.0),
                Divider(),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Deposit Amount: ', style: getCustomFont(size: 13.0, color: Colors.black54, letterSpacing: 1.2)),
                    Text('1,000.00 USD', style: getCustomFont(size: 13.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fees: ', style: getCustomFont(size: 13.0, color: Colors.black54, letterSpacing: 1.2)),
                    Text('0.00 USD', style: getCustomFont(size: 13.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Divider(),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ', style: getCustomFont(size: 13.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.2)),
                    Text('1,000.00 USD', style: getCustomFont(size: 13.0, color: Colors.black54, weight: FontWeight.w700, letterSpacing: 1.0)),
                  ],
                ),
                const SizedBox(height: 30.0),
                getButton(context, () => setState(() => currentStep = 3), text: 'Continue'),
                const SizedBox(height: 30.0),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget getSuccess() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              null,
              color: BLUECOLOR,
            ),
            Flexible(
              child: Text(
                'Deposit Money',
                style: getCustomFont(size: 18.0, color: Colors.black87, weight: FontWeight.normal, letterSpacing: 1.2),
              ),
            ),
            Icon(
              null,
              size: 20.0,
              color: Colors.black,
            )
          ]),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                Image.asset(
                  'assets/imgs/success.png',
                  width: 90.0,
                  height: 90.0,
                ),
                const SizedBox(height: 20.0),
                Text('Success!', style: getCustomFont(size: 20.0, color: Colors.green, weight: FontWeight.bold)),
                const SizedBox(height: 20.0),
                Text('Transaction Complete.', style: getCustomFont(size: 18.0, color: Colors.black54)),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text.rich(
                    TextSpan(text: 'You\'ve successfully ', children: [
                      TextSpan(
                        text: '\$1,000.00. ',
                        style: GoogleFonts.lato(color: Colors.black, fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: 'please see Transaction details under'),
                    ]),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(color: Colors.black54, fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                  ),
                ),
                const SizedBox(height: 3.0),
                Text('Activity.', style: getCustomFont(size: 13.0, color: BLUECOLOR, weight: FontWeight.w600)),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: getButton(context, () => setState(() => currentStep = 1), text: 'Deposit Money Again'),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.print, color: BLUECOLOR),
                        Text('Print', style: getCustomFont(size: 12.0, color: Colors.black54, weight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(width: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: BLUECOLOR),
                        Text('Share', style: getCustomFont(size: 12.0, color: Colors.black54, weight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
