import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class VitalAndTracks extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  VitalAndTracks(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<VitalAndTracks> createState() => _VitalAndTracksState();
}

class _VitalAndTracksState extends State<VitalAndTracks> {
  final systolic = TextEditingController();
  final diastolic = TextEditingController();
  //============================================================================
  final weightController = TextEditingController();
  //============================================================================
  final hdl = TextEditingController();
  final ldl = TextEditingController();
  final totalCholesterol = TextEditingController();
  //============================================================================
  final f_blood_sugar = TextEditingController();
  final _blood_sugar = TextEditingController();
  final aic = TextEditingController();
  //============================================================================
  final box = Hive.box<User>(BoxName);

  List vitalList = [
    {
      'color': Colors.red.withOpacity(.4),
      'icon': Icons.water_drop,
      'itemColor': Colors.redAccent,
      'title': 'Blood Pressure',
    },
    {
      'color': Colors.lightBlue.withOpacity(.4),
      'icon': FontAwesome5.pied_piper_pp,
      'itemColor': Colors.lightBlue,
      'title': 'Blood Sugar',
    },
    {
      'color': Colors.amber.withOpacity(.4),
      'icon': Icons.fingerprint_sharp,
      'itemColor': Colors.amber,
      'title': 'Cholesterol',
    },
    {
      'color': Colors.purple.withOpacity(.4),
      'icon': Icons.line_weight,
      'itemColor': Colors.purple,
      'title': 'Weight',
    },
  ];

  @override
  void dispose() {
    systolic.dispose();
    diastolic.dispose();
    weightController.dispose();
    hdl.dispose();
    ldl.dispose();
    totalCholesterol.dispose();
    f_blood_sugar.dispose();
    _blood_sugar.dispose();
    aic.dispose();
    super.dispose();
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
                          onTap: () => context.read<HomeController>().onBackPress(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 18.0,
                          )),
                      Text('Vitals And Tracks', style: getCustomFont(color: Colors.white, size: 16.0)),
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
                  child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'VITALS',
                      style: getCustomFont(size: 13.0, color: Colors.black45),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ...vitalList.map((index) => getVitalItems(index)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'TARGETS',
                      style: getCustomFont(size: 13.0, color: Colors.black45),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ]),
              )),
              getButton(context, () {}),
              const SizedBox(
                height: 10.0,
              ),
            ])),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
            child: FloatingActionButton(
              tooltip: 'Add note',
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {},
              backgroundColor: BLUECOLOR,
            ),
          ),
        ),
      ],
    );
  }

  getVitalItems(item) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white, boxShadow: SHADOW),
        child: Row(children: [
          Flexible(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: item['color'],
                  radius: 24,
                  child: Icon(
                    item['icon'],
                    size: 18.0,
                    color: item['itemColor'],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item['title']}',
                      style: getCustomFont(size: 13.0, color: Colors.black, weight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      'View record',
                      style: getCustomFont(size: 12.0, color: Colors.black45),
                    )
                  ],
                )),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onclick(item);
            },
            child: Icon(
              Icons.add,
              color: BLUECOLOR,
              size: 18.0,
            ),
          )
        ]),
      ),
    );
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'ADD NEW TARGET',
              style: getCustomFont(size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );

  onclick(item) async {
    switch (item['title']) {
      case 'Blood Pressure':
        dialogMessage(context, blood_pressure(context, systolic, diastolic, box));
        break;

      case 'Blood Sugar':
        dialogMessage(context, blood_sugar(context, box, f_blood_sugar, aic, _blood_sugar));
        break;

      case 'Cholesterol':
        dialogMessage(context, cholesterol(context, hdl, ldl, totalCholesterol, box));
        break;

      case 'Weight':
        dialogMessage(context, weight(context, weightController, box));
        break;
    }
  }
}
