import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  MyProfile(this.scaffold);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<String> headers = [
    'Overview',
    'Appointments',
    'Prescriptions',
    'Medical Records',
    'Billing'
  ];

  String index = 'Overview';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFf6f6f6),
      child: Column(
        children: [
           Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
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
                  Text('Medical Records',
                      style: getCustomFont(color: Colors.white, size: 16.0)),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  5, (index) => appointmentItem()),
                            ),
                          ),
                        )
                      : index == 'Prescriptions'
                          ? Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      5, (index) => prescriptionItem()),
                                ),
                              ),
                            )
                          : index == 'Medical Records'
                              ? Expanded(
                                  child: SingleChildScrollView(
                                      child: Column(
                                          children: [tableInvoice(context)])),
                                )
                              : index == 'Overview'
                                  ? Expanded(child: patientProfile())
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(
                                              5, (index) => billingItem()),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: index == e ? BLUECOLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0)),
            child: Text(
              '$e',
              style: getCustomFont(
                  size: 13.0,
                  color: index == e ? Colors.white : Colors.black,
                  weight: FontWeight.normal),
            )),
      );

  Widget appointmentItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: FittedBox(
                  child: Text(
                    'Booking Date - 16 Mar 2022',
                    style: getCustomFont(
                        size: 13.0,
                        color: Colors.black,
                        weight: FontWeight.w400),
                  ),
                )),
                Text(
                  'dental',
                  style: getCustomFont(
                      size: 13.0,
                      color: Colors.black45,
                      weight: FontWeight.w400),
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
                          style: getCustomFont(
                              color: Colors.black,
                              size: 16.0,
                              weight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        'Appt Date - 22 Mar 2020, 4:30PM',
                        style: getCustomFont(
                            color: Colors.black54,
                            size: 13.0,
                            weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$150.00',
                        style: getCustomFont(
                            color: Colors.black,
                            size: 13.0,
                            weight: FontWeight.w400),
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
                getButton(context, () {},
                    icon: Icons.check,
                    text: 'Confirm',
                    color: Colors.lightGreen),
                const SizedBox(
                  width: 10.0,
                ),
                getButton(context, () {},
                    icon: Icons.print,
                    text: 'Reschedule',
                    color: Colors.orange),
              ],
            )
          ],
        ));
  }

  Widget getButton(context, callBack,
          {text = 'View',
          icon = Icons.remove_red_eye,
          color = Colors.lightBlueAccent}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
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
                  style: getCustomFont(
                      size: 13.0,
                      color: Colors.white,
                      weight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  Widget prescriptionItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: FittedBox(
                      child: Text(
                                      'Prescription 1',
                                      style: getCustomFont(
                        size: 14.0, color: Colors.black, weight: FontWeight.w400),
                                    ),
                    )),
                Text(
                  '14 Mar 2022',
                  style: getCustomFont(
                      size: 14.0,
                      color: Colors.black45,
                      weight: FontWeight.w400),
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
                        style: getCustomFont(
                            color: Colors.black,
                            size: 17.0,
                            weight: FontWeight.w400),
                      ),
                      Text(
                        'Dental',
                        style: getCustomFont(
                            color: Colors.black54,
                            size: 13.0,
                            weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {},
                              color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {},
                              icon: Icons.print,
                              text: 'Print',
                              color: Colors.grey),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '#MR-0010',
                  style: getCustomFont(
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  '14 Mar 2022',
                  style: getCustomFont(
                      size: 15.0,
                      color: Colors.black45,
                      weight: FontWeight.w400),
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
                        style: getCustomFont(
                            color: Colors.black,
                            size: 19.0,
                            weight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dental',
                            style: getCustomFont(
                                color: Colors.black54,
                                size: 14.0,
                                weight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              'Dental Filling',
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 13.0,
                                  weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Dental-test.pdf',
                        style: getCustomFont(
                            color: Colors.black54,
                            size: 14.0,
                            weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {},
                              color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {},
                              icon: Icons.print,
                              text: 'Print',
                              color: Colors.grey),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '#MR-0010',
                  style: getCustomFont(
                      size: 14.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Flexible(
                  child: Text(
                    'Paid on - 14 Mar 2022',
                    style: getCustomFont(
                        size: 14.0,
                        color: Colors.black45,
                        weight: FontWeight.w400),
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
                        style: getCustomFont(
                            color: Colors.black,
                            size: 17.0,
                            weight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dental',
                            style: getCustomFont(
                                color: Colors.black54,
                                size: 13.0,
                                weight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              '\$450',
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 13.0,
                                  weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Dental-test.pdf',
                        style: getCustomFont(
                            color: Colors.black54,
                            size: 13.0,
                            weight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          getButton(context, () {},
                              color: Colors.lightGreen.shade300),
                          const SizedBox(
                            width: 10.0,
                          ),
                          getButton(context, () {},
                              icon: Icons.print,
                              text: 'Print',
                              color: Colors.grey),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: SHADOW),
                      child: Column(
                        children: [
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
                                      'Michelle Fairfax',
                                      style: getCustomFont(
                                          color: Colors.black,
                                          size: 17.0,
                                          weight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Patient ID - PT0025',
                                      style: getCustomFont(
                                          color: Colors.black54,
                                          size: 13.0,
                                          weight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Blood Group - O+',
                                      style: getCustomFont(
                                          color: Colors.black54,
                                          size: 13.0,
                                          weight: FontWeight.w400),
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
                                    Icon(Icons.phone,
                                        size: 15.0, color: Colors.black),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '+1 504 368 6874',
                                      style: getCustomFont(
                                          color: Colors.black54,
                                          size: 13.0,
                                          weight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 15.0, color: Colors.black),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Florida, USA',
                                      style: getCustomFont(
                                          color: Colors.black54,
                                          size: 13.0,
                                          weight: FontWeight.w400),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: SHADOW),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Me',
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 17.0,
                                  weight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '$DUMMYTEXT',
                              style: getCustomFont(
                                  color: Colors.black54,
                                  size: 13.0,
                                  weight: FontWeight.w400),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: SHADOW),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Booking',
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 17.0,
                                  weight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ...List.generate(2, (index) => lastBooking())
                          ])),
                )
              ],
            ),
          )
        ],
      );

  Widget lastBooking() => Column(
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
                style: getCustomFont(
                    color: Colors.black, size: 15.0, weight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            'Dentist',
            style: getCustomFont(
                color: Colors.black54, size: 13.0, weight: FontWeight.w400),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            '15 Nov 2022 4:00 PM',
            style: getCustomFont(
                color: Colors.black54, size: 13.0, weight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );

  Widget tableInvoice(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Table(
            defaultColumnWidth: FixedColumnWidth(120),
            border: TableBorder.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
                width: 1),
            children: [
              TableRow(children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('#',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Name',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('BMI',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Heart Rate',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('FBC Status',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Weight',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Order Date',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Action',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ]),
              ]),
              TableRow(children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('1',
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('John Doe',
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('23.7',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('92',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('140',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('14.2kg',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('3-Nov-2022',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text('Action',
                        maxLines: 1,
                        style: getCustomFont(
                            size: 15.0,
                            weight: FontWeight.normal,
                            color: Colors.black45)),
                  )
                ]),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
