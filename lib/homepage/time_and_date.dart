// ignore_for_file: must_be_immutable
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/constanst/weekcalender.dart';
import 'package:doccure_patient/homepage/success.dart';
import 'package:doccure_patient/model/timeing_model.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeAndDate extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  TimeAndDate(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<TimeAndDate> createState() => _TimeAndDateState();
}

class _TimeAndDateState extends State<TimeAndDate> {
  List<String> headers = ['Time and Date', 'Checkout', 'Payment'];
  List CONSULT_TYPE = [
    {'title': 'Audio Call', 'icon': Icons.spatial_audio},
    {'title': 'Video Call', 'icon': FontAwesome5.video},
    {'title': 'Chat', 'icon': FontAwesome5.facebook_messenger},
    {'title': 'Visit', 'icon': FontAwesome5.walking}
  ];
  String type = 'Audio Call';

  List<TimingModel> timemodel = [
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
    TimingModel(
        from: DateFormat('hh:mm a').format(DateTime.now()),
        to: DateFormat('hh:mm a').format(DateTime.now())),
  ];

  String index = 'Time and Date';
  int currentMonthDate = 0;

  @override
  void initState() {
    currentMonthDate = DateTime.now().month - 1;
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
                          Text('Time and Date',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.0))
                        ],
                      ),
                    ),
                    InkWell(
                          onTap: () {
                            context.read<HomeController>().setPage(12);
                          },
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                          ),
                        )
                  ],
                )
              ]),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [...headers.map((e) => _dashList(e)).toList()],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  index == 'Time and Date'
                      ? getCalenderYear(context)
                      : index == 'Checkout'
                          ? checkOut(context)
                          : getPaymentWidget(context)
                ],
              ),
            )
          ],
        ));
  }

  Widget _dashList(e) => GestureDetector(
        onTap: () => setState(() => index = e),
        child: Container(
            margin: const EdgeInsets.only(right: 5.0),
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

  Widget _dashTypeList(e) => GestureDetector(
        onTap: () => setState(() => type = e['title']),
        child: Container(
            margin: const EdgeInsets.only(right: 5.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: type == e['title'] ? BLUECOLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0)),
            child: Row(
              children: [
                Icon(
                  e['icon'],
                  color: type == e['title'] ? Colors.white : Colors.black,
                  size: 14.0,
                ),
                const SizedBox(width: 10),
                Text(
                  '${e['title']}',
                  style: getCustomFont(
                      size: 14.0,
                      color: type == e['title'] ? Colors.white : Colors.black,
                      weight: FontWeight.normal),
                ),
              ],
            )),
      );

  Widget circularButton(icon, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(width: 1.0, color: Colors.black26),
            color: Colors.white,
          ),
          child: Center(
              child: Icon(
            icon,
            color: Colors.black,
            size: 16.0,
          )),
        ),
      );

  //---------------------PAGE 1-----------------------------
  Widget getTimeItems(TimingModel timingModel, int i, context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 195,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 1.0))
            ]),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                'Timings',
                style: getCustomFont(size: 14.0, color: Colors.black),
              )),
              Icon(
                Icons.timer_outlined,
                size: 18.0,
              )
            ],
          ),
          Divider(),
          Row(
            children: [
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From',
                    style: getCustomFont(size: 14.0, color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                          child: Text(
                        timingModel.timerFrom,
                        style: getCustomFont(size: 14.0, color: Colors.black),
                      )),
                    ),
                  )
                ],
              )),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To',
                    style: getCustomFont(size: 14.0, color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                          child: Text(
                        timingModel.timerTo,
                        style: getCustomFont(size: 14.0, color: Colors.black),
                      )),
                    ),
                  )
                ],
              ))
            ],
          )
        ]),
      );

  Widget getCalenderYear(context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1.0,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 1.0))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        circularButton(Icons.arrow_back_ios, () {
                          if (DateTime.now().month - 1 < currentMonthDate) {
                            setState(() {
                              currentMonthDate = currentMonthDate - 1;
                            });
                          }
                        }),
                        Text(
                          '${month[currentMonthDate]} ${DateTime.now().year}',
                          style: getCustomFont(
                              size: 15.0,
                              color: Colors.black,
                              weight: FontWeight.w400),
                        ),
                        circularButton(Icons.arrow_forward_ios, () {
                          if (currentMonthDate < month.length - 1) {
                            setState(() {
                              currentMonthDate = currentMonthDate + 1;
                            });
                          }
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CalendarWeek(
                      controller: CalendarWeekController(),
                      height: 100,
                      showMonth: false,
                      minDate: DateTime.now().add(
                        Duration(days: -365),
                      ),
                      maxDate: DateTime.now().add(
                        Duration(days: 365),
                      ),
                      onDatePressed: (DateTime datetime) {
                        // Do something
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...CONSULT_TYPE.map((e) => _dashTypeList(e)).toList()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.all(0.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: returnCrossAxis(width),
                                  mainAxisSpacing: 15.0,
                                  mainAxisExtent: 135,
                                  crossAxisSpacing: 8.0),
                          itemCount: timemodel.length,
                          itemBuilder: (ctx, i) =>
                              getTimeItems(timemodel[i], i, context)))
                ],
              ),
            ),
            getButton1(context, () {
              setState(() {
                index = 'Checkout';
              });
            })
          ],
        ),
      ),
    );
  }

  //======================PAYMENT==============================
  getPaymentWidget(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment Information',
                      style: getCustomFont(size: 17.0, color: Colors.black)),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: SHADOW,
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: false,
                                groupValue: false,
                                onChanged: (b) {}),
                            Text(
                              'Paypal',
                              style: getCustomFont(
                                  size: 16.0, color: Colors.black45),
                            )
                          ],
                        ),
                        Icon(FontAwesome5.paypal, size: 24.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        boxShadow: SHADOW,
                        color: Colors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: false,
                                      groupValue: false,
                                      onChanged: (b) {}),
                                  Text(
                                    'Card',
                                    style: getCustomFont(
                                        size: 16.0, color: Colors.black45),
                                  )
                                ],
                              ),
                              Icon(FontAwesome5.cc_mastercard, size: 24.0),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        getCardForm('Name on card', ''),
                        const SizedBox(height: 18.0),
                        getCardForm('Card Number', '5466 1234 5574 4775'),
                        const SizedBox(height: 18.0),
                        Row(
                          children: [
                            Flexible(
                              child: getCardForm('Expiry Month', 'MM'),
                            ),
                            Flexible(
                              child: getCardForm('Expiry Year', 'YY'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        getCardForm('CVV', ''),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text('I have read and accept ',
                            style:
                                getCustomFont(size: 15.0, color: Colors.black)),
                        Text('Terms & Conditions',
                            style: getCustomFont(size: 15.0, color: BLUECOLOR)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            getPayButton(context, (){
              Get.to(() => PaymentSuccess());
            }),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  getCardForm(label, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$label',
                style: getCustomFont(size: 13.0, color: Colors.black45),
              ),
              Text(
                '*',
                style: getCustomFont(color: Colors.red, size: 13.0),
              )
            ],
          ),
          const SizedBox(height: 5.0),
          SizedBox(
            height: 45.0,
            child: TextField(
              style: getCustomFont(size: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0))),
            ),
          )
        ],
      ),
    );
  }

   Widget getPayButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Center(
              child: Text(
                'Confirm And Pay',
                style: GoogleFonts.poppins(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );

  int returnCrossAxis(width) {
    return width < 500
        ? 2
        : width > 500 && width < 100
            ? 2
            : 3;
  }

  Widget getButton1(context, callBack, {text = 'Continue'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );
  //-----------------------PAGE 2 -----------------------------
  Widget checkOut(context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: SHADOW),
                child: Row(children: [
                  CircleAvatar(
                    radius: 40.0,
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
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '(47)',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14.0,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Florida, USA',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Booking Summary',
                style: getCustomFont(
                    size: 20.0, color: Colors.black, weight: FontWeight.normal),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children:
                      List.generate(1, (index) => bookSummaryItem(context)),
                ),
              )),
              getButton(context, () {
                setState(() {
                  index = 'Payment';
                });
              })
            ],
          ),
        ),
      );

  bookSummaryItem(context) => Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
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
              Text(
                'Date',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '16 Nov 2022',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '10:00 AM',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consulting Fee',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$100',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Means',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Video call',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Patient Country',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Nigeria',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Slot Timing Fees',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\$10',
                style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
        ],
      ));

  Widget getButton(context, callBack, {text = 'Search Now'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total - \$75',
                  style: GoogleFonts.poppins(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );

  //-----------------------BOOKING FORM---------------------------
  getBookingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You are booking a visit with Dr. Rajendra Mohanlal Gandhi. Please enter your booking details below.',
          style: getCustomFont(size: 13.0, color: Colors.black),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          'Are you booking for yourself?',
          style: getCustomFont(size: 13.0, color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Radio(value: false, groupValue: true, onChanged: (b) {}),
              Text(
                'Yes',
                style: getCustomFont(size: 13.0, color: Colors.black),
              ),
            ]),
            Row(children: [
              Radio(value: false, groupValue: true, onChanged: (b) {}),
              Text(
                'No',
                style: getCustomFont(size: 13.0, color: Colors.black),
              ),
            ])
          ],
        ),
        Text(
          'Patient Name',
          style: getCustomFont(size: 13.0, color: Colors.black),
        ),
        TextFormField(
          style: getCustomFont(size: 13.0, color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Enter Patient Name',
            hintStyle: getCustomFont(size: 13.0, color: Colors.black45),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          'Do you have insurance?',
          style: getCustomFont(size: 13.0, color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Radio(value: false, groupValue: true, onChanged: (b) {}),
              Text(
                'Yes',
                style: getCustomFont(size: 13.0, color: Colors.black),
              ),
            ]),
            Row(children: [
              Radio(value: false, groupValue: true, onChanged: (b) {}),
              Text(
                'No',
                style: getCustomFont(size: 13.0, color: Colors.black),
              ),
            ])
          ],
        ),
        TextFormField(
          style: getCustomFont(size: 13.0, color: Colors.black),
          maxLines: 10,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              hintText: 'Enter Patient Name',
              hintStyle: getCustomFont(size: 13.0, color: Colors.black45),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.black))),
        ),
      ],
    );
  }
}