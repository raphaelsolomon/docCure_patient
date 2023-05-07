import 'dart:convert';

import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/model/prescription_model.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Prescriptions extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const Prescriptions(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  bool isLoading = true;
  PrescriptionModel? prescriptionModel;
  final box = Hive.box<User>(BoxName);
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPrescriptions(_refreshController).then((value) => setState(() {
            this.prescriptionModel = value;
            isLoading = false;
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
                      onTap: () => context.read<HomeController>().onBackPress(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18.0,
                      )),
                  Text('Prescriptions', style: getCustomFont(color: Colors.white, size: 16.0)),
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
            height: 10.0,
          ),
          Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: BLUECOLOR))
                  : SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                      onRefresh: () => getPrescriptions(_refreshController).then((value) => setState(() {
                            this.prescriptionModel = value;
                          })),
                      child: ListView.builder(padding: const EdgeInsets.all(0.0), itemCount: prescriptionModel!.data!.length, shrinkWrap: true, itemBuilder: ((context, i) => prescriptionItem(prescriptionModel!.data![i]))),
                    ))
        ]));
  }

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
                  style: getCustomFont(size: 14.0, color: Colors.white, weight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Future<PrescriptionModel> getPrescriptions(RefreshController controller) async {
    PrescriptionModel model = new PrescriptionModel();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/prescriptions/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return model = PrescriptionModel.fromJson(jsonDecode(value));
      });
    }
    controller.refreshFailed();
    return model;
  }
}
