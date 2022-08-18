import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class VitalAndTracks extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  VitalAndTracks(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<VitalAndTracks> createState() => _VitalAndTracksState();
}

class _VitalAndTracksState extends State<VitalAndTracks> {
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
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 100.0,
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
                        GestureDetector(
                            onTap: () =>
                                widget.scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Vital & Tracks',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  )
                ],
              )
            ]),
          ),
          Expanded(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'VITALS',
                  style: getCustomFont(size: 16.0, color: Colors.black45),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              ...vitalList.map((index) => getVitalItems(index)),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'TARGETS',
                  style: getCustomFont(size: 16.0, color: Colors.black45),
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
        ]));
  }

  getVitalItems(item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: SHADOW),
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
                    style: getCustomFont(
                        size: 16.0,
                        color: Colors.black,
                        weight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  Text(
                    'View record',
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                  )
                ],
              )),
            ],
          ),
        ),
        Icon(
          Icons.add,
          color: BLUECOLOR,
          size: 18.0,
        )
      ]),
    );
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'ADD NEW TARGET',
              style: getCustomFont(
                  size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );
}
