import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

dialogMessage(BuildContext context, widget) {
  showDialog(context: context, builder: (BuildContext context) => widget);
}

Widget language(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(9.0),
                width: MediaQuery.of(context).size.width,
                color: BLUECOLOR,
                child: Center(
                  child: Text(
                        'Choose Language',
                        style: getCustomFont(size: 20.0, color: Colors.black),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Widget medicalDetails(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add new data',
                      style: getCustomFont(size: 15.0, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 17.0,
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
                Divider(),
                const SizedBox(
                  height: 20.0,
                ),
               getMedialDetailsBox('BMI', ''),
                const SizedBox(
                  height: 10.0,
                ),
                getMedialDetailsBox('Heart Rate', ''),
                const SizedBox(
                  height: 10.0,
                ),
                getMedialDetailsBox('Weight', ''),
                const SizedBox(
                  height: 10.0,
                ),
                getMedialDetailsBox('Fbc', ''),
                const SizedBox(
                  height: 10.0,
                ),
                getMedialDetailsBox('Created Date', ''),
                const SizedBox(
                  height: 20.0,
                ),
                Divider(),
                getPayButton(context, () {}, 'Submit'),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget subscribe(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      'X',
                      style: getCustomFont(size: 20.0, color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'assets/auth/1.jpeg',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Stay In Touch',
                  style: getCustomFont(
                      size: 20.0,
                      color: Colors.black,
                      weight: FontWeight.bold)),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Stay connected for future\nupdate and new products',
                textAlign: TextAlign.center,
                style: getCustomFont(size: 16.0, color: Colors.black),
              ),
              const SizedBox(
                height: 15.0,
              ),
              getFormSubscribe(ctl: null),
              const SizedBox(
                height: 20.0,
              ),
              getButton(context, () {}, 'Subscribe Now'),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget referral(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'X',
                    style: getCustomFont(size: 20.0, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'assets/auth/1.jpeg',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Do you have Referral Codes?',
                  style: getCustomFont(
                      size: 20.0,
                      color: Colors.black,
                      weight: FontWeight.bold)),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Add Referral Codes and get your first cashback now',
                textAlign: TextAlign.center,
                style: getCustomFont(size: 16.0, color: Colors.black),
              ),
              const SizedBox(
                height: 15.0,
              ),
              getFormSubscribe(ctl: null, hint: 'Add 6 digit referral code'),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    'I Dont have',
                    style: getCustomFont(size: 14.0, color: Colors.black),
                  )),
                  Flexible(
                      child: Text(
                    'Continue',
                    style: getCustomFont(size: 14.0, color: BLUECOLOR),
                  ))
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget familyPop(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Family',
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                  ),
                  Text(
                    'X',
                    style: getCustomFont(size: 20.0, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Icon(
                Icons.add_home_sharp,
                size: 70.0,
                color: BLUECOLOR,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Are you sure you want to create a family',
              textAlign: TextAlign.center,
                  style: getCustomFont(
                      size: 20.0,
                      color: Colors.black,
                      weight: FontWeight.bold)),
              const SizedBox(
                height: 10.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200),
                                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                                      child: Text(
                      'Cancel',
                      style: getCustomFont(size: 15.0, color: Colors.black),
                                      ),
                                    ),
                    )),
                Flexible(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        dialogMessage(context, familyPopStart(context));
                      },
                      child: Container(
                                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: BLUECOLOR),
                                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                                      child: Text(
                      'Continue',
                      style: getCustomFont(size: 15.0, color: Colors.white),
                                      ),
                                    ),
                    )),
              ]),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget familyPopStart(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Family Member',
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                  ),
                  Text(
                    'X',
                    style: getCustomFont(size: 20.0, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              getFamilyFormBox(ctl: null),
              const SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.shade200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Cancel',
                    style: getCustomFont(size: 14.0, color: Colors.black),
                  ),
                )),
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: BLUECOLOR),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Add Member',
                    style: getCustomFont(size: 14.0, color: Colors.white),
                  ),
                )),
              ]),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget blood_pressure(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ADD NEW RECORD',
                    style: getCustomFont(size: 15.0, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 17.0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              getFormBox('Systolic', 'Type here', 'mmHg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Top numbers usually between 90 - 250',
                  style: getCustomFont(size: 11.0, color: Colors.black45),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              getFormBox('Diastolic', 'Type here', 'mmHg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'bottom numbers usually between 60 - 140',
                  style: getCustomFont(size: 11.0, color: Colors.black45),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              getPayButton(context, () {}, 'SAVE'),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget cholesterol(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ADD NEW RECORD',
                      style: getCustomFont(size: 15.0, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 17.0,
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                dropDown(text: 'Preferred Unit', label: 'Select Type'),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox('HDL Cholesterol', 'Type here', 'Mg/Dl'),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox('LDL Cholesterol', 'Type here', 'Mg/Dl'),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox('Total Cholesterol', 'Type here', 'Mg/Dl'),
                const SizedBox(
                  height: 20.0,
                ),
                getPayButton(context, () {}, 'SAVE'),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget blood_sugar(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ADD NEW RECORD',
                      style: getCustomFont(size: 15.0, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 17.0,
                        color: Colors.black45,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                dropDown(text: 'Preferred Unit', label: 'Select Type'),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox('Fast blood sugar', 'Type here', 'Mg/Dl'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'usually between 70.0 to 130.0 Mg/Dl',
                    style: getCustomFont(size: 11.0, color: Colors.black45),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox(
                    'Blood sugar 1-2 hours after meal', 'Type here', 'Mg/Dl'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'usually less than 180.0 Mg/Dl',
                    style: getCustomFont(size: 11.0, color: Colors.black45),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                getFormBox('A1C(%)', 'Type here', ''),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'usually less than 7%',
                    style: getCustomFont(size: 11.0, color: Colors.black45),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                getPayButton(context, () {}, 'SAVE'),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget weight(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ADD NEW RECORD',
                    style: getCustomFont(size: 15.0, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 17.0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              getFormBox('Weight', 'Type here', 'Kg'),
              const SizedBox(
                height: 20.0,
              ),
              getPayButton(context, () {}, 'SAVE'),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

getFormBox(text, hint, unit, {ctl}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text',
          style: getCustomFont(size: 12.0, color: Colors.black),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Row(
          children: [
            Flexible(
              child: SizedBox(
                height: 45.0,
                child: TextField(
                  style: getCustomFont(size: 14.0, color: Colors.black45),
                  maxLines: 1,
                  controller: ctl,
                  decoration: InputDecoration(
                      hintText: hint,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle:
                          getCustomFont(size: 14.0, color: Colors.black45),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0))),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              '$unit',
              style: getCustomFont(size: 12.0, color: Colors.black),
            ),
          ],
        )
      ],
    ),
  );
}

getMedialDetailsBox(text, hint, {ctl}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$text',
          style: getCustomFont(size: 12.0, color: Colors.black),
        ),
        const SizedBox(
          height: 7.0,
        ),
        SizedBox(
          height: 45.0,
          child: TextField(
            style: getCustomFont(size: 14.0, color: Colors.black45),
            maxLines: 1,
            controller: ctl,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0),
                hintStyle:
                    getCustomFont(size: 14.0, color: Colors.black45),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        )
      ],
    ),
  );
}

getFamilyFormBox({ctl}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter the members email address',
          style: getCustomFont(size: 13.0, color: Colors.black),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Container(
          height: 45.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1.0, color: Colors.grey.shade400)),
          child: Row(
            children: [
              const SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.email,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: TextField(
                  style: getCustomFont(size: 14.0, color: Colors.black45),
                  maxLines: 1,
                  controller: ctl,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

getFormSubscribe({ctl, hint = 'Email Address'}) => Container(
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey.shade200),
      child: TextField(
        maxLines: 1,
        controller: ctl,
        keyboardType: TextInputType.emailAddress,
        style: getCustomFont(size: 16.0, color: Colors.black54),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            hintText: hint,
            hintStyle: getCustomFont(size: 16.0, color: Colors.black54),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );

Widget getPayButton(context, callBack, text) => GestureDetector(
      onTap: () => callBack(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: BLUECOLOR, borderRadius: BorderRadius.circular(6.0)),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Center(
            child: Text(
              '$text',
              style: getCustomFont(
                  size: 18.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );

Widget getButton(context, callBack, text,
        {textColor = Colors.white, bgColor = BLUECOLOR}) =>
    GestureDetector(
      onTap: () => callBack(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(100.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              '$text',
              style: getCustomFont(
                  size: 18.0, color: textColor, weight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );

Widget rateUsPop(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        margin:
            const EdgeInsets.all(40), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 20, right: 20), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'X',
                    style: getCustomFont(size: 20.0, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Rate Us',
                  style: getCustomFont(
                      size: 20.0,
                      color: Colors.black,
                      weight: FontWeight.bold)),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Hey, Love us? Express it!',
                textAlign: TextAlign.center,
                style: getCustomFont(size: 16.0, color: Colors.black),
              ),
              const SizedBox(
                height: 15.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 19.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: BLUECOLOR,
                  size: 15.0,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: getButton(context, () {
                      Navigator.pop(context);
                    }, 'Later', bgColor: Colors.grey, textColor: Colors.black),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: getButton(context, () {}, 'Rate It'),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
