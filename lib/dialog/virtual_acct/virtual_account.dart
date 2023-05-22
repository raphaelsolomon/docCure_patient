import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class VirtualAccount extends StatefulWidget {
  const VirtualAccount({Key? key}) : super(key: key);

  @override
  State<VirtualAccount> createState() => _VirtualAccountState();
}

class _VirtualAccountState extends State<VirtualAccount> {
  int page = 0;
  int selectedCurrency = 0;
  String bankType = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height /
          (page == 0
              ? 2.7
              : page == 3
                  ? 1.8
                  : page == 2 || page == 4
                      ? 2.5
                      : 2.2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.orange.withOpacity(.03), borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
        child: page == 0
            ? pageOne()
            : page == 1
                ? pageTwo()
                : page == 2
                    ? pageThree()
                    : page == 3
                        ? createAccount()
                        : successPage(),
      ),
    );
  }

  Widget pageOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(children: [
          const SizedBox(width: 10.0),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.keyboard_backspace,
                color: BLUECOLOR,
              )),
          const SizedBox(width: 30.0),
          Flexible(
            child: Text(
              'Request Virtual Account',
              style: getCustomFont(size: 15.0, color: BLUECOLOR, weight: FontWeight.bold),
            ),
          ),
        ]),
        Divider(),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              'This works like a typical bank account, account will be created for you to receive payments in that currency and make payoutsin all supported currency',
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(color: Colors.black87, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
            ),
          ),
          const Spacer(),
          getButton(context, () => setState(() => page = 1), text: 'Request Virtual Account'),
          const SizedBox(
            height: 30.0,
          ),
        ]))
      ],
    );
  }

  Widget pageTwo() {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          'Setup a Bank Account',
          style: getCustomFont(size: 16.0, color: BLUECOLOR, weight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Icon(Icons.euro_rounded, color: Colors.purple.withOpacity(.3), size: 70.0),
        const SizedBox(height: 10.0),
        Text(
          'This works just like any regular bank account. You will get an IBAN which enables you to send and recieve NGN payments.',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
        ),
        Spacer(),
        getButton(context, () => setState(() => page = 2)),
        Spacer(),
      ],
    );
  }

  Widget pageThree() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            'Setup a Bank Account',
            style: getCustomFont(size: 16.0, color: Colors.deepPurple, weight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            'Select Currency',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.deepPurple, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5.0),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: .2, color: Colors.black54)),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const SizedBox(width: 15.0),
                      Image.asset(
                        'assets/ads/multi.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                          child: Text(
                        'MultiCurrency',
                        style: GoogleFonts.lato(color: Colors.black54, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black54),
                  child: Radio(
                      activeColor: Colors.deepPurple,
                      value: selectedCurrency == 0,
                      groupValue: true,
                      onChanged: (b) => setState(() {
                            selectedCurrency = 0;
                          })),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: .2, color: Colors.black54)),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const SizedBox(width: 15.0),
                      Image.asset(
                        'assets/ads/nigeria.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                          child: Text(
                        'Nigerian Naira(NGN)',
                        style: GoogleFonts.lato(color: Colors.black54, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w600),
                      )),
                    ],
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black54),
                  child: Radio(
                      activeColor: Colors.deepPurple,
                      value: selectedCurrency == 1,
                      groupValue: true,
                      onChanged: (b) => setState(() {
                            selectedCurrency = 1;
                          })),
                )
              ],
            ),
          ),
          Spacer(),
          getButton(context, () => setState(() => page = 3)),
          Spacer(),
        ],
      ),
    );
  }

  Widget createAccount() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(children: [
            const SizedBox(width: 10.0),
            GestureDetector(
                onTap: () => setState(() {
                      page = 2;
                    }),
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.deepPurple,
                )),
            const SizedBox(width: 30.0),
            Flexible(
              child: Text(
                'Account Information',
                style: getCustomFont(size: 15.0, color: Colors.deepPurple, weight: FontWeight.bold),
              ),
            ),
          ]),
          const SizedBox(height: 10.0),
          Text(
            'Kindly provide the information below to complete your request.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black54, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
          ),
          const SizedBox(height: 30.0),
          getCardForm('Account Name', 'John Doe', ctl: null),
          const SizedBox(height: 3.0),
          Text(
            'This virtual account will be created with the BVN of the director above',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(color: Colors.black54, fontSize: 8.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
          ),
          const SizedBox(height: 20.0),
          getDropDownAssurance('Bank'),
          Spacer(),
          getButton(context, () => setState(() => page = 4)),
          Spacer(),
        ],
      ));

  Widget successPage() {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          'Your account has been approved successfully',
          textAlign: TextAlign.center,
          style: getCustomFont(size: 14.0, color: Colors.deepPurple, weight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Icon(Icons.euro_rounded, color: Colors.purple.withOpacity(.3), size: 70.0),
        const SizedBox(height: 10.0),
        Text(
          'Your requested virtual account has been approved successfully.',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(color: Colors.black54, fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400),
        ),
        Spacer(),
        getButton(context, () => setState(() => page = 2), text: 'Okay, Got it'),
        const SizedBox(height: 30.0),
      ],
    );
  }

  getCardForm(hint, label, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.deepPurple, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.deepPurple), borderRadius: BorderRadius.circular(5.0)),
            child: TextField(
              controller: ctl,
              style: getCustomFont(size: 14.0, color: Colors.black45),
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: label, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 13.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
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
            style: GoogleFonts.lato(color: Colors.deepPurple, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 49.0,
          decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.deepPurple), borderRadius: BorderRadius.circular(5.0)),
          child: FormBuilderDropdown<String>(
            name: 'select',
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            onChanged: (value) => bankType = value!,
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
                        style: getCustomFont(size: 13.0, color: Colors.black45),
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
              style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );
}
