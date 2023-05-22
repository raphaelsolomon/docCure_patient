import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPayLink extends StatefulWidget {
  const AddPayLink({super.key});

  @override
  State<AddPayLink> createState() => _AddPayLinkState();
}

class _AddPayLinkState extends State<AddPayLink> {
  String paymentMethod = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: pageOne(),
    );
  }

  Widget pageOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            null,
            color: Colors.deepPurple,
          ),
          Flexible(
            child: Text(
              'Create a Payment Link',
              style: getCustomFont(size: 20.0, color: Colors.black, weight: FontWeight.normal, letterSpacing: 1.0),
            ),
          ),
          Icon(
            null,
            color: Colors.deepPurple,
          ),
        ]),
        Divider(),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20.0,
              ),
              getCardForm('Payment Link Name', 'Consultastion payment Link', ctl: null),
              const SizedBox(
                height: 15.0,
              ),
              getCardFormRich('Description', 'Dentist consultastion for vip patient 1 week', ctl: null),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Flexible(child: getCardForm('Amount', '1,000.00', ctl: null, keyboardType: TextInputType.number)),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(child: getDropDownAssurance(['Nigeria', 'Ghana', 'Australia'], 'Payment Link Name')),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      activeColor: BLUECOLOR,
                      onChanged: (b) => setState(() {
                            isChecked = b!;
                          })),
                  Text('Allow Customer to change Amount', style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2))
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              getDropDownAssurance(['2131212312', '312342342343', '243224534'], 'Settlement Destination', label: 'Bank Account'),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), color: Colors.lightBlueAccent.shade100.withOpacity(.4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Text('Bank Name', style: getCustomFont(size: 11.0, color: Colors.black, letterSpacing: 1.2, weight: FontWeight.w800)),
                          const SizedBox(height: 10.0),
                          Text('Zenith Bank', style: getCustomFont(size: 12.0, color: Colors.black54, weight: FontWeight.w500, letterSpacing: 1.2)),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Text('Account Number', style: getCustomFont(size: 11.0, color: Colors.black, letterSpacing: 1.2, weight: FontWeight.w800)),
                          const SizedBox(height: 10.0),
                          Text('1123632621', style: getCustomFont(size: 12.0, color: Colors.black54, weight: FontWeight.w500, letterSpacing: 1.2)),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              getDropDownAssurance(['Customer', 'Merchant'], 'Who bears the fee', label: 'Customer'),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      activeColor: BLUECOLOR,
                      onChanged: (b) => setState(() {
                            isChecked = b!;
                          })),
                  Text('Generate short link', style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2))
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              getButton(context, () => setState(() => null), text: 'Create'),
              const SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        ))
      ],
    );
  }

  getCardForm(hint, label, {ctl, visible = false, keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 45.0,
            decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              children: [
                visible
                    ? Container(
                        height: 45.0,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                        decoration: BoxDecoration(border: Border.all(width: .1, color: Colors.grey.shade200), borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)), color: Colors.grey.shade200),
                        child: Text('\$', style: GoogleFonts.lato(color: Colors.black54, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                      )
                    : const SizedBox(),
                Flexible(
                  child: TextField(
                    controller: ctl,
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                    //onChanged: (value) => setState(() => amount = value),
                    maxLines: 1,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                        hintText: label, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 13.0, color: Colors.black45, letterSpacing: 1.2), border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getCardFormRich(hint, label, {ctl, visible = false, keyboardType = TextInputType.multiline}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 5.0),
          Container(
            height: null,
            decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
            child: TextField(
              controller: ctl,
              style: getCustomFont(size: 14.0, color: Colors.black45, letterSpacing: 1.0),
              // onChanged: (value) => setState(() => amount = value),
              maxLines: null,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: label, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 13.0, color: Colors.black45, letterSpacing: 1.0), border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }

  getDropDownAssurance(List<String> list, hint, {label = 'Select Currency'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
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
              hintText: label,
              hintStyle: getCustomFont(size: 13.0, color: Colors.black45, letterSpacing: 1.2),
              contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
            ),
            items: list
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
}
