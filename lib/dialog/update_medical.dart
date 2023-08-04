import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;
import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditMedical extends StatefulWidget {
  final Map<String, dynamic> medicalRecord;
  const EditMedical(this.medicalRecord, {Key? key}) : super(key: key);

  @override
  State<EditMedical> createState() => _EditMedicalState();
}

class _EditMedicalState extends State<EditMedical> {
  bool isloading = false;

  final fullname = TextEditingController();
  final bmi = TextEditingController();
  final heartRate = TextEditingController();
  final fcb = TextEditingController();
  final weight = TextEditingController();

  final box = Hive.box<User>(BoxName);

  @override
  void initState() {
    fullname.text = '${widget.medicalRecord['name']}';
    bmi.text = '${widget.medicalRecord['bmi']}';
    heartRate.text = '${widget.medicalRecord['heart_rate']}';
    fcb.text = '${widget.medicalRecord['fbc_status']}';
    weight.text = '${widget.medicalRecord['weight']}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                'Add Medical Record',
                style: getCustomFont(size: 14.0, color: Colors.black),
              )),
              Icon(
                Icons.cancel_outlined,
                color: Colors.black45,
              ),
            ],
          ),
          Divider(),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Name',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                getCardForm('Name', ctl: fullname),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'BMI',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                getCardForm('BMI', ctl: bmi),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Heart Rate',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                getCardForm('Heart Rate', ctl: heartRate),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'FBC Status',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                getCardForm('FBC Status', ctl: fcb),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Weight',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                getCardForm('Weight', ctl: weight),
                const SizedBox(
                  height: 30.0,
                ),
                Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                isloading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: BLUECOLOR,
                        )))
                    : getButton(context, () => onExecute()),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget getUploadForm(String text, {callBack}) => Container(
        height: 45.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
          color: BLUECOLOR.withOpacity(.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => callBack(),
              child: Container(
                height: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
                  color: Colors.grey.shade300,
                ),
                child: Center(
                    child: Text(
                  'Choose File',
                  style: getCustomFont(size: 13.0, color: Colors.black),
                )),
              ),
            ),
            Flexible(child: Text('$text', style: getCustomFont(size: 13.0, color: Colors.black45))),
          ],
        ),
      );

  getCardForm(hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: BLUECOLOR.withOpacity(.1)),
        child: TextField(
          style: getCustomFont(size: 12.0, color: Colors.black45),
          controller: ctl,
          maxLines: 1,
          decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 12.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  getDropDownAssurance({onChange}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 49.0,
      decoration: BoxDecoration(color: BLUECOLOR.withOpacity(.1), borderRadius: BorderRadius.circular(5.0)),
      child: FormBuilderDropdown(
        name: 'gender',
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
        ),
        initialValue: 'Male',
        onChanged: (s) => onChange(s),
        items: ['Male', 'Female']
            .map((gender) => DropdownMenuItem(
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

  getBloodGroup({onChange}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 49.0,
      decoration: BoxDecoration(color: BLUECOLOR.withOpacity(.1), borderRadius: BorderRadius.circular(5.0)),
      child: FormBuilderDropdown(
        name: 'bloodgroup',
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
        ),
        initialValue: 'AA',
        onChanged: (s) => onChange(s),
        items: ['AA', 'AB', 'O-', 'O+']
            .map((gender) => DropdownMenuItem(
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

  Widget getDateForm(text, callBack) => Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
          color: BLUECOLOR.withOpacity(.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('$text', style: getCustomFont(size: 13.0, color: Colors.black45)),
            )),
            GestureDetector(
              onTap: () => callBack(),
              child: PhysicalModel(
                elevation: 10.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 9.0),
                  child: Icon(
                    Icons.calendar_month,
                    size: 17.0,
                    color: Color(0xFF838383),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget getPhoenNumber(ctl) => Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
          color: BLUECOLOR.withOpacity(.1),
        ),
        child: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: PhoneFormField(
                key: Key('phone-field'),
                controller: ctl, // controller & initialValue value
                shouldFormat: true, // default
                defaultCountry: 'NG', // default
                style: getCustomFont(size: 14.0, color: Colors.black45),
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0.0),
                    hintText: 'Mobile Number', // default to null
                    hintStyle: getCustomFont(size: 15.0, color: Colors.black45),
                    border: OutlineInputBorder(borderSide: BorderSide.none) // default to UnderlineInputBorder(),
                    ),
                validator: null,

                showFlagInInput: true, // default
                flagSize: 15, // default
                autofillHints: [AutofillHints.telephoneNumber], // default to null
                enabled: true, // default
              ),
            )),
            PhysicalModel(
              elevation: 10.0,
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Icon(
                  Icons.smartphone,
                  size: 18.0,
                  color: Color(0xFF838383),
                ),
              ),
            )
          ],
        ),
      );

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Add Medical Record',
              style: getCustomFont(size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );

  void onExecute() async {
    if (fullname.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Medical name is not valid'));
      return;
    }

    if (weight.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Weight is not valid'));
      return;
    }

    if (fcb.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'FBC status is not valid'));
      return;
    }

    if (heartRate.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Heart Rate is not valid'));
      return;
    }

    if (bmi.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'BMI is not valid'));
      return;
    }

    setState(() {
      isloading = true;
    });

    try {
      var request = http.Request('PATCH', Uri.parse('${ROOTAPI}/api/v1/auth/patient/records/other-medical-record/edit/${widget.medicalRecord['id']}'));
      request.body = jsonEncode({
        'name': fullname.text,
        "bmi": bmi.text.trim(),
        "heart_rate": heartRate.text.trim(),
        "fbc_status": fcb.text.trim(),
        "weight": weight.text.trim(),
      });
      request.headers.addAll({
        'Authorization': '${box.get(USERPATH)!.token}',
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setState(() => isloading = false);
        popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Dependent Updated successfully', status: true));
      } else {
        setState(() => isloading = false);
        popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
      }
    } on SocketException {
      setState(() => isloading = false);
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Check Internet Connection', status: false));
    }
  }
}
