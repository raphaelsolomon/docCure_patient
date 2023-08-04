import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/add_medical.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/dialog/update_medical.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/model/prescription_model.dart';
import 'package:doccure_patient/providers/loading.controller.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfile extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  MyProfile(this.scaffold);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<String> headers = ['Overview', 'Appointments', 'Prescriptions', 'Medical Records', 'Billing'];
  final box = Hive.box<User>(BoxName);

  String index = 'Overview';
  String country = '';

  PrescriptionModel? presModel;
  Map<String, dynamic> appointmentResult = {};
  Map<String, dynamic> medicalRecordResult = {};
  Map<String, dynamic> lastBookingRecordResult = {};

  bool isPrescriptionLoading = true;
  bool isAppointmentLoading = true;
  bool isMedicalRecordLoading = true;
  bool lastBookRecords = true;

  final _refreshController = RefreshController(initialRefresh: false);
  final _refreshAppointController = RefreshController(initialRefresh: false);
  final _refreshMedicalController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      index = context.read<LoadingController>().index;
      var i = countryList.indexWhere((e) => '${e['id']}' == '${box.get(USERPATH)!.country}');
      country = countryList.elementAt(i)['name'] ?? '';
      ApiServices.getPrescriptions(_refreshController, box).then((value) => setState(() {
            this.presModel = value;
            isPrescriptionLoading = false;
          }));

      ApiServices.getAppointments(_refreshAppointController, box).then((value) => setState(() {
            this.appointmentResult = value;
            isAppointmentLoading = false;
          }));

      ApiServices.getAllMedicalRecords(_refreshMedicalController, context, box).then((value) => setState(() {
            this.medicalRecordResult = value;
            isMedicalRecordLoading = false;
          }));

      ApiServices.getLastBookRecords(context, box).then((value) => setState(() {
            this.lastBookRecords = false;
            lastBookingRecordResult = value;
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
      child: Column(
        children: [
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
                      onTap: () => context.read<HomeController>().onBackPress(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18.0,
                      )),
                  Text('Medical Records', style: getCustomFont(color: Colors.white, size: 16.0)),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [...headers.map((e) => _dashList(e)).toList()],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  index == 'Appointments'
                      ? Expanded(
                          child: isAppointmentLoading
                              ? Center(child: CircularProgressIndicator(color: BLUECOLOR))
                              : SmartRefresher(
                                  controller: _refreshAppointController,
                                  enablePullDown: true,
                                  header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                                  onRefresh: () => ApiServices.getAppointments(_refreshAppointController, box).then((value) => setState(() {
                                        this.appointmentResult = value;
                                      })),
                                  child: appointmentResult.isNotEmpty && appointmentResult['data']!.isEmpty
                                      ? Center(
                                          child: Text(
                                          'Patient has no appointment booked yet!',
                                          style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w400),
                                        ))
                                      : ListView.builder(
                                          padding: const EdgeInsets.all(0.0),
                                          itemCount: appointmentResult.isEmpty ? 0 : presModel!.data!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (ctx, index) => appointmentItem(),
                                        ),
                                ),
                        )
                      : index == 'Prescriptions'
                          ? Expanded(
                              child: isPrescriptionLoading
                                  ? Center(child: CircularProgressIndicator(color: BLUECOLOR))
                                  : SmartRefresher(
                                      controller: _refreshController,
                                      enablePullDown: true,
                                      header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                                      onRefresh: () => ApiServices.getPrescriptions(_refreshController, box).then((value) => setState(() {
                                            this.presModel = value;
                                          })),
                                      child: presModel != null && presModel!.data!.isEmpty
                                          ? Center(
                                              child: Text(
                                              'No Prescription Found',
                                              style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w400),
                                            ))
                                          : ListView.builder(
                                              padding: const EdgeInsets.all(0.0),
                                              itemCount: presModel == null ? 0 : presModel!.data!.length,
                                              shrinkWrap: true,
                                              itemBuilder: ((context, i) => prescriptionItem(presModel!.data![i])),
                                            ),
                                    ))
                          : index == 'Medical Records'
                              ? Expanded(
                                  child: SmartRefresher(
                                  controller: _refreshMedicalController,
                                  enablePullDown: true,
                                  header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                                  onRefresh: () => ApiServices.getAllMedicalRecords(_refreshMedicalController, context, box).then((value) => setState(() {
                                        this.medicalRecordResult = value;
                                      })),
                                  child: Stack(
                                    children: [
                                      tableInvoice(context),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                          child: FloatingActionButton.extended(
                                            label: Text('Add Record'),
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            onPressed: () => showRequestSheet(context, AddMedical()),
                                            backgroundColor: BLUECOLOR,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              : index == 'Overview'
                                  ? Expanded(child: patientProfile())
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(5, (index) => billingItem()),
                                        ),
                                      ),
                                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dashList(e) => GestureDetector(
        onTap: () => setState(() => index = e),
        child: Container(
            margin: const EdgeInsets.only(right: 3.0),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(color: index == e ? BLUECOLOR : Colors.transparent, borderRadius: BorderRadius.circular(50.0)),
            child: Text(
              '$e',
              style: getCustomFont(size: 12.0, color: index == e ? Colors.white : Colors.black, weight: FontWeight.normal),
            )),
      );

  Widget appointmentItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: FittedBox(
                  child: Text(
                    'Booking Date - 16 Mar 2022',
                    style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w400),
                  ),
                )),
                Text(
                  'dental',
                  style: getCustomFont(size: 13.0, color: Colors.black45, weight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 27.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Dr. Ruby Perrln',
                          style: getCustomFont(color: Colors.black, size: 16.0, weight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        'Appt Date - 22 Mar 2020, 4:30PM',
                        style: getCustomFont(color: Colors.black54, size: 13.0, weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$150.00',
                        style: getCustomFont(color: Colors.black, size: 13.0, weight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButton(context, () {}),
                const SizedBox(
                  width: 10.0,
                ),
                getButton(context, () {}, icon: Icons.check, text: 'Confirm', color: Colors.lightGreen),
                const SizedBox(
                  width: 10.0,
                ),
                getButton(context, () {}, icon: Icons.print, text: 'Reschedule', color: Colors.orange),
              ],
            )
          ],
        ));
  }

  Widget getButton(context, callBack, {text = 'View', icon = Icons.remove_red_eye, color = Colors.lightBlueAccent}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 14.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Text(
                  '$text',
                  style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Widget prescriptionItem(PrescriptionData data) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: FittedBox(
                  child: Text(
                    'Prescription ${data.id}',
                    style: getCustomFont(size: 14.0, color: Colors.black, weight: FontWeight.w400),
                  ),
                )),
                Text(
                  '${DateFormat('dd, MMM, yyyy').format(DateTime.parse(data.createdAt!))}',
                  style: getCustomFont(size: 14.0, color: Colors.black45, weight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 27.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.doctorName}',
                        style: getCustomFont(color: Colors.black, size: 17.0, weight: FontWeight.w400),
                      ),
                      Text(
                        '${data.specialization}',
                        style: getCustomFont(color: Colors.black54, size: 13.0, weight: FontWeight.w400),
                      ),
                      Text(
                        '${data.name}, ${data.quantity}',
                        style: getCustomFont(color: Colors.black54, size: 13.0, weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {}, color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {}, icon: Icons.delete_forever, text: 'Delete', color: Colors.redAccent),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget medicalRecordItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '#MR-0010',
                  style: getCustomFont(size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  '14 Mar 2022',
                  style: getCustomFont(size: 15.0, color: Colors.black45, weight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Ruby Perrln',
                        style: getCustomFont(color: Colors.black, size: 19.0, weight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dental',
                            style: getCustomFont(color: Colors.black54, size: 14.0, weight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              'Dental Filling',
                              style: getCustomFont(color: Colors.black, size: 13.0, weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Dental-test.pdf',
                        style: getCustomFont(color: Colors.black54, size: 14.0, weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {}, color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {}, icon: Icons.print, text: 'Print', color: Colors.grey),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget billingItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '#MR-0010',
                  style: getCustomFont(size: 12.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Flexible(
                  child: Text(
                    'Paid on - 14 Mar 2022',
                    style: getCustomFont(size: 11.0, color: Colors.black45, weight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 27.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Ruby Perrln',
                        style: getCustomFont(color: Colors.black, size: 15.0, weight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dental',
                            style: getCustomFont(color: Colors.black54, size: 12.0, weight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              '\$450',
                              style: getCustomFont(color: Colors.black, size: 12.0, weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Dental-test.pdf',
                        style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {}, color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {}, icon: Icons.print, text: 'Print', color: Colors.grey),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget patientProfile() => Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35.0,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: PhysicalModel(
                        elevation: 10.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Icon(
                            FontAwesome5.info,
                            size: 15.0,
                            color: Color(0xFF838383),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: VerticalDivider(
                          color: Colors.black45,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Container(
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 27.0,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: NetworkImage(
                                  box.get(USERPATH)!.profilePhoto!.replaceAll('http://localhost:8003', ROOTAPI),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${box.get(USERPATH)!.name}',
                                      style: getCustomFont(color: Colors.black, size: 14.0, weight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Patient ID - PT${box.get(USERPATH)!.uid}',
                                      style: getCustomFont(color: Colors.black54, size: 12.0, weight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Blood Group - ${box.get(USERPATH)!.bloodgroup}',
                                      style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, size: 15.0, color: Colors.black),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${box.get(USERPATH)!.phone}',
                                      style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.location_on, size: 15.0, color: Colors.black),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${box.get(USERPATH)!.state}, ${country}',
                                      style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 0.0,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35.0,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: PhysicalModel(
                        elevation: 10.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Icon(
                            FontAwesome5.user,
                            size: 15.0,
                            color: Color(0xFF838383),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: VerticalDivider(
                          color: Colors.black45,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Container(
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          'About Me',
                          style: getCustomFont(color: Colors.black, size: 14.0, weight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${box.get(USERPATH)!.about_me ?? ''}',
                          style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w400),
                        ),
                      ])),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 0.0,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35.0,
                  child: Stack(children: [
                    PhysicalModel(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Icon(
                          FontAwesome5.medkit,
                          size: 15.0,
                          color: Color(0xFF838383),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: VerticalDivider(
                          color: Colors.transparent,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Container(
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white, boxShadow: SHADOW),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          'Last Booking',
                          style: getCustomFont(color: Colors.black, size: 15.0, weight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        lastBookingRecordResult.isEmpty ? const SizedBox() : lastBooking(lastBookingRecordResult)
                      ])),
                )
              ],
            ),
          )
        ],
      );

  Widget lastBooking(Map<String, dynamic> lastBookingRecordResult) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check, size: 14.0, color: Colors.black),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                'Last Booking',
                style: getCustomFont(color: Colors.black, size: 13.0, weight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            'Dentist',
            style: getCustomFont(color: Colors.black54, size: 12.0, weight: FontWeight.w400),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            '15 Nov 2022 4:00 PM',
            style: getCustomFont(color: Colors.black54, size: 11.0, weight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );

  Widget tableInvoice(context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: ApiServices.getAllOtherMedicalRecords(context, box.get(USERPATH)!.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!['data'].length > 0) {
              return tableHeader(snapshot.data!['data']);
            }
            return tableHeader([]);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: BLUECOLOR),
            );
          }
          return tableHeader([]);
        });
  }

  tableChild(e) => TableRow(children: [
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['id']}', style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['name']}', style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['bmi']}', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['heart_rate']}', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['fbc_status']}', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${e['weight']}Kg', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text('${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse('${e['order_date']}'))}', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.normal, color: Colors.black45)),
          )
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => showRequestSheet(context, EditMedical(e)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(color: BLUECOLOR.withOpacity(.9), borderRadius: BorderRadius.circular(4.0)),
                      child: Text('Edit', maxLines: 1, style: getCustomFont(size: 9.0, weight: FontWeight.normal, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () => ApiServices.deleteOtherMedicalRecord(context, box.get(USERPATH)!.token, '${e['id']}', () => setState(() {})),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(color: Colors.red.withOpacity(.9), borderRadius: BorderRadius.circular(4.0)),
                      child: Text('Del', maxLines: 1, style: getCustomFont(size: 9.0, weight: FontWeight.normal, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ]);

  Widget tableHeader(List item) => SingleChildScrollView(
          child: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Table(
                defaultColumnWidth: FixedColumnWidth(120),
                border: TableBorder.all(color: Colors.grey.shade300, style: BorderStyle.solid, width: 1),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('#', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('Name', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('BMI', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('Heart Rate', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('FBC Status', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('Weight', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('Order Date', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Text('Action', maxLines: 1, style: getCustomFont(size: 12.0, weight: FontWeight.bold, color: Colors.black)),
                      )
                    ]),
                  ]),
                  ...item.map((e) => tableChild(e)).toList()
                ],
              ),
            ],
          ),
        ),
      ]));
}
