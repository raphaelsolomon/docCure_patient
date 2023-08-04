import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/loading.controller.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/prescription_model.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  HomePage(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box<User>(BoxName);
  final _controller = RefreshController(initialRefresh: false);

  PrescriptionModel? _prescription;
  Map<String, dynamic> getAppointments = {"status": true, "message": "Patient has no appointment booked yet!", "data": []};
  Map<String, dynamic> getmedicalRecords = {"status": true, "message": "No medical record found!", "data": []};

  List firstList = [
    {'title': 'Heart Rate', 'icon': 'assets/imgs/heart.png', 'count': '12', 'unit': 'bmp'},
    {'title': 'weight', 'icon': 'assets/imgs/temp.png', 'count': '18', 'unit': 'c'},
    {'title': 'Blood Sugar', 'icon': 'assets/imgs/gas.png', 'count': '70 - 90', 'unit': ''},
    {'title': 'Blood Pressure', 'icon': 'assets/imgs/pressure.png', 'count': '202/90', 'unit': 'mg/dl'},
  ];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ApiServices.getPrescriptions(_controller, box).then((value) => setState(() {
            this._prescription = value;
          }));

      ApiServices.getAppointments(_controller, box).then((value) => setState(() {
            this.getAppointments = value;
          }));

      ApiServices.getAllMedicalRecords(_controller, context, box).then((value) => setState(() {
            print(value);
            this.getmedicalRecords = value;
          }));
      //=========================`==============================================================================
      ApiServices.getWeight(box).then((value) => setState(() {
            firstList[1]['count'] = value['data']['weight'];
          }));
      ApiServices.getBloodPressure(box).then((value) => setState(() {
            firstList[3]['count'] = value['data'][0][0]['blood_pressure'];
          }));
      ApiServices.getCholesterol(box).then((value) => setState(() {
            firstList[0]['count'] = value['data'].last['cholesterol'];
          }));
      ApiServices.getBloodSugar(box).then((value) => setState(() {
            firstList[2]['count'] = value['data'][0][0]['blood_sugar'];
          }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  color: BLUECOLOR,
                  child: Column(children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              GestureDetector(onTap: () => widget.scaffold.currentState!.openDrawer(), child: Icon(Icons.menu, color: Colors.white)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('DashBoard', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15.0))
                            ],
                          ),
                        ),
                        Icon(
                          null,
                          color: Colors.white,
                        )
                      ],
                    )
                  ]),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: dashWidget(context, size: getAppointments['data'].length ?? '0', progress: 1.0, onCallBack: () {
                                  context.read<HomeController>().setPage(-10);
                                  context.read<LoadingController>().setProfileIndex(value: "Appointments");
                                  if (context.read<HomeController>().isEstoreClicked) {
                                    context.read<HomeController>().isEstore(false);
                                    Navigator.pop(context);
                                  }
                                }),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                child: dashWidget(context, size: _prescription == null ? '0' : _prescription!.data!.length, text: 'Prescriptions', icon: Icons.medication_liquid, progress: 1.0, onCallBack: () {
                                  context.read<HomeController>().setPage(-10);
                                  context.read<LoadingController>().setProfileIndex(value: "Prescriptions");
                                  if (context.read<HomeController>().isEstoreClicked) {
                                    context.read<HomeController>().isEstore(false);
                                    Navigator.pop(context);
                                  }
                                }),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: dashWidget(context, size: getmedicalRecords['data'].length ?? '0', text: 'Medical Records', icon: Icons.folder_copy, progress: 1.0, onCallBack: () {
                                  context.read<HomeController>().setPage(-10);
                                  context.read<LoadingController>().setProfileIndex(value: "Medical Records");
                                  if (context.read<HomeController>().isEstoreClicked) {
                                    context.read<HomeController>().isEstore(false);
                                    Navigator.pop(context);
                                  }
                                }),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                child: dashWidget(context, text: 'Billing', icon: Icons.payment, progress: 1.0),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [...firstList.map((e) => firstSlide(e)).toList()],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [...secondList.map((e) => secondSlide(e)).toList()],
                          ),
                        ),
                        const SizedBox(
                          height: 90.0,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
              top: 82.0,
              right: 0,
              left: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black26, spreadRadius: 1.0, blurRadius: 10.0, offset: Offset(0.0, 1.0))], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            box.get(USERPATH)!.profilePhoto!.replaceAll('http://localhost:8003', ROOTAPI),
                            width: 90,
                            height: 90,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/imgs/1.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.contain,
                            ),
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${box.get(USERPATH)!.name!}',
                              style: getCustomFont(size: 15.0, color: Colors.black, weight: FontWeight.w400),
                            ),
                            Text(
                              '2022-05-05',
                              style: getCustomFont(size: 12.0, color: Colors.black54, weight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      'Blood Group O-',
                                      style: getCustomFont(size: 11.0, color: Colors.red, weight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      '(Lagos, Nigeria)',
                                      style: getCustomFont(size: 11.0, color: Colors.black45, weight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  dashWidget(context, {icon = FontAwesome5.calendar_day, text = "Appointments", progress = 0.8, color = BLUECOLOR, onCallBack, size = "0"}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.white),
      child: Column(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 8.0,
            percent: progress,
            center: Icon(
              icon,
              size: 40.0,
              color: color,
            ),
            backgroundColor: Colors.grey.shade100,
            progressColor: BLUECOLOR,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '$text',
          style: getCustomFont(size: 15.0, color: Colors.black),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '$size',
          style: getCustomFont(size: 15.0, color: Colors.black, weight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), color: BLUECOLOR),
          child: InkWell(
            onTap: () => onCallBack(),
            child: Text(
              'view',
              style: getCustomFont(size: 14.0, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
      ]),
    );
  }

  Widget firstSlide(e) => Container(
      width: 125.0,
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), border: Border.all(width: 1.0, color: Colors.grey.shade300), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Image.asset(
            '${e['icon']}',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 7.0,
          ),
          FittedBox(
            child: Text(
              '${e['title']}',
              style: getCustomFont(size: 12.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: FittedBox(
                  child: Text(
                    '${e['count']}',
                    style: getCustomFont(size: 14.0, color: Colors.black),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Text(
              //     '${e['unit']}',
              //     style: getCustomFont(size: 11.0, color: Colors.black),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 7.0,
          ),
        ],
      ));

  Widget secondSlide(data) => Container(
      width: 130.0,
      height: 143.0,
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0), color: data['color']),
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                '${data['title']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getCustomFont(size: 13.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Image.asset(
            '${data['icon']}',
            width: 50.0,
            height: 40.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                '${data['date']}',
                style: getCustomFont(size: 13.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
        ],
      ));
}
