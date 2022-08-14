import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';

class MyAppointment extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const MyAppointment(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  List<String> headers = [
    'Appointments',
    'Prescriptions',
    'Medical Records',
    'Billing'
  ];

  String index = 'Appointments';

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
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 90.0,
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
                        Text('Patient Appointment',
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [...headers.map((e) => _dashList(e)).toList()],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
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
                                      children: List.generate(
                                          5, (index) => medicalRecordItem()),
                                    ),
                                  ),
                                )
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
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: index == e ? BLUECOLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0)),
            child: Text(
              '$e',
              style: getCustomFont(
                  size: 15.0,
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
                    child: Text(
                  'Booking Date - 16 Mar 2022',
                  style: getCustomFont(
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  'dental',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ruby Perrln',
                      style: getCustomFont(
                          color: Colors.black,
                          size: 19.0,
                          weight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'Appt Date - 22 Mar 2020, 4:30PM',
                      style: getCustomFont(
                          color: Colors.black54,
                          size: 14.0,
                          weight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '\$150.00',
                      style: getCustomFont(
                          color: Colors.black,
                          size: 14.0,
                          weight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButton(context, () {},
                    icon: Icons.check,
                    text: 'Confirm',
                    color: Colors.lightGreen),
                const SizedBox(
                  width: 10.0,
                ),
                getButton(context, () {}),
                const SizedBox(
                  width: 10.0,
                ),
                getButton(context, () {},
                    icon: Icons.print, text: 'Print', color: Colors.grey),
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
                      size: 14.0,
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
                    child: Text(
                  'Prescription 1',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ruby Perrln',
                      style: getCustomFont(
                          color: Colors.black,
                          size: 19.0,
                          weight: FontWeight.w400),
                    ),
                    Text(
                      'Dental',
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
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  'Paid on - 14 Mar 2022',
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
}
