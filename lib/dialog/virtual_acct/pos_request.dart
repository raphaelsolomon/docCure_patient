import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class PosRequest extends StatefulWidget {
  const PosRequest({super.key});

  @override
  State<PosRequest> createState() => _PosRequestState();
}

class _PosRequestState extends State<PosRequest> {
  String paymentMethod = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: getFormPage(),
    );
  }

  getFormPage() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              null,
              color: BLUECOLOR,
            ),
            Flexible(
              child: Text(
                'POS Terminal Request',
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
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text.rich(
              TextSpan(text: 'Request for your POS Terminal from anywhere', children: []),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.0, fontWeight: FontWeight.w400, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(height: 20.0),
                getDropDownAssurance(['Traction SOLO', 'Traction ONE'], 'Select Accessory type'),
                const SizedBox(height: 15.0),
                getDropDownAssurance(['Traction SOLO', 'Traction ONE'], 'Select Option Plan', label: 'Option Plan'),
                const SizedBox(height: 15.0),
                getCardForm('Numbers Of POS', '10', keyboardType: TextInputType.number),
                const SizedBox(height: 15.0),
                getCardForm('Email Address', 'johnDoe@example.com'),
                const SizedBox(height: 15.0),
                getCardForm('Mobile Number', '+xxx xxxxxxxxx'),
                const SizedBox(height: 15.0),
                getCardForm('Address', '+xxx xxxxxxxxx'),
                const SizedBox(height: 15.0),
                getCardForm('City', '+xxx xxxxxxxxx'),
                const SizedBox(height: 20.0),
                getDropDownAssurance(['Nigeria', 'Ghana', 'Australia'], 'Select Country', label: 'Select Country'),
                const SizedBox(height: 40.0),
                getButton(context, () {}, text: 'Send Request'),
                const SizedBox(height: 40.0),
              ]),
            ),
          ))
        ],
      ),
    );
  }

  getDropDownAssurance(List<String> list, hint, {label = 'Select Accessory'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '$hint',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
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
              hintText: '$label',
              hintStyle: getCustomFont(size: 13.0, color: Colors.black45),
              contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
              border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
            ),
            items: list
                .map((gender) => DropdownMenuItem<String>(
                      value: gender,
                      child: Text(
                        gender,
                        style: getCustomFont(size: 13.0, color: Colors.black87),
                      ),
                    ))
                .toList(),
          ),
        ),
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
            style: GoogleFonts.lato(color: Colors.black54, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.w500, letterSpacing: 1.2),
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
                    //onChanged: (value) => setState(() => amount = value),
                    maxLines: 1,
                    keyboardType: keyboardType,
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
