import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/model/reminder_model.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;

class MyReminder extends StatefulWidget {
  const MyReminder({Key? key}) : super(key: key);

  @override
  State<MyReminder> createState() => _MyReminderState();
}

class _MyReminderState extends State<MyReminder> {
  int counter = 0;
  List days = [];
  String frequency = '';
  bool isActive = false;
  final pillname = TextEditingController();
  final pillNumbers = TextEditingController();
  bool addButtonLoading = false;

  bool isLoading = false;
  ReminderModel? reminderModel = ReminderModel(message: '', status: null, data: []);
  final box = Hive.box<User>(BoxName);
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getReminders(_refreshController).then((value) => setState(() {
            this.reminderModel = value;
            isLoading = false;
          }));
    });
    super.initState();
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                width: MediaQuery.of(context).size.width,
                color: BLUECOLOR,
                child: Column(children: [
                  const SizedBox(
                    height: 45.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (counter == 0) {
                              context.read<HomeController>().onBackPress();
                            } else {
                              setState(() {
                                counter = 0;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 18.0,
                          )),
                      Text('Reminder', style: getCustomFont(color: Colors.white, size: 16.0)),
                      Icon(
                        null,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ]),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Expanded(
                  child: counter == 0
                      ? isLoading
                          ? Center(child: CircularProgressIndicator(color: BLUECOLOR))
                          : SmartRefresher(
                              controller: _refreshController,
                              enablePullDown: true,
                              header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                              onRefresh: () => getReminders(_refreshController).then((value) => setState(() {
                                    this.reminderModel = value;
                                  })),
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(0.0),
                                  itemCount: reminderModel!.data!.length,
                                  itemBuilder: (ctx, i) {
                                    List<String> listdays = [];
                                    reminderModel!.data![i].reminderDates!.forEach((element) => listdays.add(element.date!));
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.0), boxShadow: SHADOW),
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
                                            fit: FlexFit.tight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${reminderModel!.data![i].pillName}', style: getCustomFont(size: 16.0, weight: FontWeight.w500, color: Colors.black)),
                                                const SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text('${listdays.join(', ')}', style: getCustomFont(size: 14.0, weight: FontWeight.normal, color: Colors.black54)),
                                                const SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text('${reminderModel!.data![i].noOfTimes} times, ${reminderModel!.data![i].frequency}', style: getCustomFont(size: 14.0, weight: FontWeight.w500, color: Colors.black54))
                                              ],
                                            ),
                                          ),
                                          reminderModel!.data![i].isDeleteLoading
                                              ? SizedBox(
                                                  height: 20.0,
                                                  width: 20.0,
                                                  child: CircularProgressIndicator(
                                                    color: BLUECOLOR,
                                                    strokeWidth: 1.5,
                                                  ),
                                                )
                                              : GestureDetector(onTap: () => onDelete(reminderModel!.data, i), child: Icon(Icons.delete_forever, color: Colors.redAccent))
                                        ],
                                      ),
                                    );
                                  }),
                            )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 25.0,
                              ),
                              getCardForm('Reminder Name', 'Enter Reminder Name', ctl: pillname),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'Select Days',
                                  style: getCustomFont(size: 14.0, color: Colors.black45, weight: FontWeight.w500),
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
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'Frequency',
                                  style: getCustomFont(size: 14.0, color: Colors.black45, weight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              getDropDownAssurance(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [Flexible(child: getCardForm('Numbers of times', 'Enter Number of times', ctl: pillNumbers))],
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              addButtonLoading ? Center(child: CircularProgressIndicator(color: BLUECOLOR)) : getPayButton(context, () => addReminders()),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ))
            ])),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: isActive
                ? const SizedBox()
                : FloatingActionButton(
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
      decoration: BoxDecoration(color: BLUECOLOR.withOpacity(.1), borderRadius: BorderRadius.circular(5.0)),
      child: FormBuilderDropdown(
        name: 'skill',
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
          border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide.none),
        ),
        initialValue: 'Daily',
        onChanged: (value) => frequency = '$value',
        items: ['Daily', 'Bi-Weekly', 'Weekly', 'Bi-Monthly', 'Monthly', 'Quarterly', 'Bi-Yearly', 'Yearly']
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
            style: getCustomFont(size: 14.0, color: Colors.black45, weight: FontWeight.w500),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 48.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: BLUECOLOR.withOpacity(.1)),
            child: TextField(
              controller: ctl,
              style: getCustomFont(size: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 14.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }

  showPickerArray(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<String>(pickerData: JsonDecoder().convert(PickerData2), isArray: true),
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: BLUECOLOR.withOpacity(.1)),
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
                style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: BLUECOLOR.withOpacity(.1)),
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
              style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w500),
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
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Submit',
              style: getCustomFont(size: 15.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );

  Future<ReminderModel> getReminders(RefreshController controller) async {
    ReminderModel model = new ReminderModel();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/reminders/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return model = ReminderModel.fromJson(jsonDecode(value));
      });
    }
    controller.refreshFailed();
    return model;
  }

  Future<void> addReminders() async {
    if (pillname.text.trim().isEmpty) {
      return;
    }

    if (days.isEmpty) {
      return;
    }

    if (frequency.trim().isEmpty) {
      return;
    }

    if (pillNumbers.text.trim().isEmpty) {
      return;
    }

    setState(() {
      //addButtonLoading = true;

      var reminder =
          ReminderData(id: Random().nextInt(2312), patientId: '41133', pillName: pillname.text, noOfTimes: pillNumbers.text, frequency: frequency, createdAt: '', reminderDates: days.map<ReminderDates>((e) => ReminderDates(date: e)).toList());
      reminderModel!.data!.add(reminder);
      counter = 0;
    });
    try {
      final response = await http.Client().post(Uri.parse('${ROOTAPI}/api/v1/auth/patient/reminders/add'),
          body: jsonEncode({
            "pill_name": "Chlorophinecol",
            "reminder_dates": [
              {"date": "Monday"},
              {"date": "Tuesday"},
              {"date": "Friday"},
              {"date": "Sunday"}
            ],
            "frequency": "Daily",
            "no_of_times": "2"
          }),
          headers: {'Authorization': '${box.get(USERPATH)!.token}', 'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return getReminders(_refreshController).then((value) => setState(() {
              this.reminderModel = value;
              isLoading = false;
              return popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, jsonDecode(response.body)['message'], status: true));
            }));
      }
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
    } on SocketException {
    } finally {
      setState(() {
        addButtonLoading = false;
      });
    }
  }

  onDelete(List<ReminderData>? data, int i) async {
    setState(() {
      reminderModel!.data!.removeAt(i);
    });
    // setState(() {
    //   data![i].setisDeleteLoading(true);
    // });

    // try {
    //   var request = http.Request('DELETE', Uri.parse('${ROOTAPI}/api/v1/auth/patient/reminders/delete/${data![i].id}'));
    //   request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    //   http.StreamedResponse response = await request.send();
    //   if (response.statusCode == 200) {
    //     return response.stream.bytesToString().then((value) {
    //       data.removeAt(i);
    //       return popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, jsonDecode(value)['message'], status: true));
    //     });
    //   } else {
    //     return popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
    //   }
    // } on SocketException {
    //   popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Please Check Internet Connection', status: false));
    // } finally {
    //   setState(() {
    //     data![i].setisDeleteLoading(false);
    //   });
    // }
  }
}
