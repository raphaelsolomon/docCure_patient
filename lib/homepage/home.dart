import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const HomePage(this.scaffold, {Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
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
                              GestureDetector(
                                  onTap: () =>
                                      scaffold.currentState!.openDrawer(),
                                  child: Icon(Icons.menu, color: Colors.white)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('DashBoard',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 18.0))
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
                          child: Row(children: [
                            Flexible(child: dashWidget(context, progress: 0.6),),
                            const SizedBox(width: 10.0,),
                             Flexible(child: dashWidget(context, text: 'Prescriptions', icon: Icons.medication_liquid, progress: 0.3),)
                          ],),
                        ),
                        const SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(children: [
                            Flexible(child: dashWidget(context, text: 'Medical Records', icon: Icons.folder_copy, progress: 0.5),),
                            const SizedBox(width: 10.0,),
                             Flexible(child: dashWidget(context, text: 'Billing', icon: Icons.payment, progress: 0.2),)
                          ],),
                        ),
                        const SizedBox(height: 20.0,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(4, (index) => firstSlide())
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...secondList.map((e) => secondSlide(e)).toList()
                            ],
                          ),
                        )
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1.0,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 1.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/imgs/3.png',
                            width: 90,
                            height: 90,
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
                              'John Smith',
                              style: getCustomFont(
                                  size: 20.0,
                                  color: Colors.black,
                                  weight: FontWeight.w400),
                            ),
                            Text(
                              '2022-05-05',
                              style: getCustomFont(
                                  size: 12.0,
                                  color: Colors.black54,
                                  weight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Blood Group O-',
                                    style: getCustomFont(
                                        size: 13.0,
                                        color: Colors.red,
                                        weight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  '(Lagos, Nigeria)',
                                  style: getCustomFont(
                                      size: 13.0,
                                      color: Colors.black45,
                                      weight: FontWeight.w400),
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

  dashWidget(context, {icon =FontAwesome5.calendar_day, text = "Appointments", progress = 0.8, color = BLUECOLOR}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), 
          color: Colors.white),
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
                  progressColor: BLUECOLOR,),
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
          '0',
          style: getCustomFont(
              size: 15.0, color: Colors.black, weight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0), color: BLUECOLOR),
          child: Text(
            'view',
            style: getCustomFont(size: 14.0, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
      ]),
    );
  }

  Widget firstSlide() => Container(
      width: 110.0,
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0, color: Colors.grey.shade300),
          color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Icon(Icons.monitor_heart_outlined, color: Colors.red),
          const SizedBox(
            height: 7.0,
          ),
          Text(
            'Heart Rate',
            style: getCustomFont(size: 12.0, color: Colors.black),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '12',
                style: getCustomFont(size: 14.0, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'bpm',
                  style: getCustomFont(size: 12.0, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 7.0,
          ),
        ],
      ));

  Widget secondSlide(data) => Container(
      width: 130.0,
      height: 139.0,
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0), color: data['color']),
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Text(
            '${data['title']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getCustomFont(size: 14.0, color: Colors.white),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Icon(data['icon'], color: data['iconColor']),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${data['date']}',
            style: getCustomFont(size: 13.0, color: Colors.white),
          ),
          const SizedBox(
            height: 2.0,
          ),
        ],
      ));
}
