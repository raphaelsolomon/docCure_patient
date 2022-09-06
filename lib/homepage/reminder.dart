import 'dart:convert';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyReminder extends StatefulWidget {
  const MyReminder({Key? key}) : super(key: key);

  @override
  State<MyReminder> createState() => _MyReminderState();
}

class _MyReminderState extends State<MyReminder> {
  int counter = 0;
  List days = [];
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFf6f6f6),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 0.0),
                width: MediaQuery.of(context).size.width,
                height: 89.0,
                color: BLUECOLOR,
                child: Column(children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (counter <= 0) {
                              context.read<HomeController>().onBackPress();
                            } else {
                              setState(() {
                                counter = counter - 1;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.0,
                          )),
                      Text(counter == 0 ? 'Reminders' : 'Create Reminder',
                          style:
                              getCustomFont(size: 18.0, color: Colors.white)),
                      Icon(
                        null,
                        color: Colors.white,
                      )
                    ],
                  )
                ]),
              ),
              Expanded(
                  child: counter == 0
                      ? ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          itemCount: 5,
                          itemBuilder: (ctx, i) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 4.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0),
                                  boxShadow: SHADOW),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28.0,
                                    backgroundColor: BLUECOLOR.withOpacity(.1),
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: BLUECOLOR,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Diabetes Pills',
                                            style: getCustomFont(
                                                size: 15.0,
                                                weight: FontWeight.w500,
                                                color: Colors.black)),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text('Mon, Tue, Wed, Thurs, Sat, Sun',
                                            style: getCustomFont(
                                                size: 13.0,
                                                weight: FontWeight.normal,
                                                color: Colors.black45)),
                                                const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                            '08: 00 am, 12:00 pm, 03:30 pm, 06:00 pm',
                                            style: getCustomFont(
                                                size: 12.0,
                                                weight: FontWeight.w500,
                                                color: Colors.black54))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 25.0,
                            ),
                            getCardForm('Pill Name', 'Enter Pill Name'),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Select Days',
                                style: getCustomFont(
                                    size: 14.0,
                                    color: Colors.black45,
                                    weight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            getDaysForm(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Frequency',
                                style: getCustomFont(
                                    size: 14.0,
                                    color: Colors.black45,
                                    weight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            getDropDownAssurance(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Select Times',
                                style: getCustomFont(
                                    size: 14.0,
                                    color: Colors.black45,
                                    weight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Flexible(child: getTimeForm()),
                                GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    print(formatTimeOfDay(picked!));
                                  },
                                  child: Container(
                                    height: 48.0,
                                    margin: const EdgeInsets.only(right: 15.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: BLUECOLOR.withOpacity(.3)),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                             const SizedBox(
                              height: 40.0,
                            ),
                            getPayButton(context, () {}),
                             const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ))
            ])),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: FloatingActionButton(
              tooltip: 'Add note',
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  counter = 1;
                });
              },
              backgroundColor: BLUECOLOR,
            ),
          ),
        ),
      ],
    );
  }

  getDropDownAssurance() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 49.0,
      decoration: BoxDecoration(
          color: BLUECOLOR.withOpacity(.1),
          borderRadius: BorderRadius.circular(5.0)),
      child: FormBuilderDropdown(
        name: 'skill',
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide.none),
        ),
        initialValue: 'Daily',
        items: [
          'Daily',
          'Bi-Weekly',
          'Weekly',
          'Bi-Monthly',
          'Monthly',
          'Quarterly',
          'Bi-Yearly',
          'Yearly'
        ]
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(
                    gender,
                    style: getCustomFont(size: 13.0, color: Colors.black),
                  ),
                ))
            .toList(),
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: getCustomFont(
                size: 14.0, color: Colors.black45, weight: FontWeight.w500),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: BLUECOLOR.withOpacity(.1)),
            child: TextField(
              style: getCustomFont(size: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  showPickerArray(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(PickerData2), isArray: true),
      hideHeader: false,
      title: new Text(
        "Select Days",
        style: getCustomFont(size: 18.0, color: Colors.black),
      ),
      textAlign: TextAlign.center,
      textStyle: getCustomFont(size: 14.0, color: Colors.black),
      onConfirm: (Picker picker, List value) {
        isActive = false;
        days = picker.getSelectedValues().where((e) => e != 'Non').toList();
        setState(() {});
      },
      onCancel: () {
        setState(() {
          isActive = false;
        });
      },
    ).showBottomSheet(context);
  }

  getDaysForm() {
    return GestureDetector(
      onTap: () {
        showPickerArray(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          height: 48.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: BLUECOLOR.withOpacity(.1)),
          child: Row(
            children: [
              const SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.calendar_month_rounded,
                color: BLUECOLOR,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                  child: Text(
                days.join(', '),
                style: getCustomFont(
                    size: 13.0, color: Colors.black, weight: FontWeight.w500),
              )),
            ],
          ),
        ),
      ),
    );
  }

  getTimeForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: BLUECOLOR.withOpacity(.1)),
        child: Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.notifications,
              color: BLUECOLOR,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
                child: Text(
              days.join(', '),
              style: getCustomFont(
                  size: 13.0, color: Colors.black, weight: FontWeight.w500),
            )),
          ],
        ),
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Widget getPayButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Submit',
              style: getCustomFont(
                  size: 15.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );
}