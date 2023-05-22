import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversionPage extends StatefulWidget {
  const ConversionPage({super.key});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
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
                'Convert Currency',
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
              TextSpan(text: 'Convert between any of the available pairs.', children: []),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(color: Colors.black54, fontSize: 12.0, height: 1.4, fontWeight: FontWeight.w400, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(height: 20.0),
                getCardForm('I want to convert', '', ctl: null),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(width: double.infinity, child: Text('Available Balance - NGN 102,322,344.00 ', textAlign: TextAlign.end, style: getCustomFont(size: 10.0, color: Colors.black54, letterSpacing: 1.2, weight: FontWeight.w800))),
                const SizedBox(
                  height: 10.0,
                ),
                getCardForm('I want to receive', '', ctl: null),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), color: Colors.lightBlueAccent.shade100.withOpacity(.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20.0),
                                Text('Exchange Rate: ', style: getCustomFont(size: 11.0, color: Colors.black54, letterSpacing: 1.2, weight: FontWeight.w800)),
                                const SizedBox(height: 10.0),
                                Text('1 NGN = 0.00 USD', style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w500, letterSpacing: 1.2)),
                                const SizedBox(height: 7.0),
                                Text('1 USD = NGN 388.50', style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w500, letterSpacing: 1.2)),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20.0),
                                Text('Transaction fee', style: getCustomFont(size: 11.0, color: Colors.black54, letterSpacing: 1.2, weight: FontWeight.w800)),
                                const SizedBox(height: 10.0),
                                Text('NGN 1,000.00', style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w500, letterSpacing: 1.2)),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text('Settlement Date: ', style: getCustomFont(size: 11.0, color: Colors.black54, letterSpacing: 1.2, weight: FontWeight.w800)),
                      const SizedBox(height: 10.0),
                      Text('12/5/2023 16:04:32', style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w500, letterSpacing: 1.2)),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  'New quote will be generated in 22s',
                  style: getCustomFont(size: 11.0, color: Colors.black, weight: FontWeight.normal, letterSpacing: 1.2),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                getButton(context, () {}, text: 'Convert to USD 254.83'),
                const SizedBox(
                  height: 30.0,
                ),
              ]),
            ),
          ))
        ],
      ),
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
            style: GoogleFonts.lato(color: Colors.black87, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 5.0),
          Container(
            height: 45.0,
            decoration: BoxDecoration(border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(width: .5, color: Colors.grey), borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0))),
                      child: FormBuilderDropdown<String>(
                        name: 'select',
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        onChanged: (value) => paymentMethod = value!,
                        decoration: InputDecoration(
                          hintText: 'NGN',
                          hintStyle: getCustomFont(size: 13.0, color: Colors.black, letterSpacing: 1.2, weight: FontWeight.w500),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
                          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
                        ),
                        items: ['Paystack', 'Fincra']
                            .map((gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: getCustomFont(size: 13.0, color: Colors.black87),
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: ctl,
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                    // onChanged: (value) => setState(() => amount = value),
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
            style: GoogleFonts.lato(color: Colors.black, fontSize: 13.0, height: 1.4, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        const SizedBox(height: 5.0),
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
