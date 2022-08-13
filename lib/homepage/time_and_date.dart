// ignore_for_file: must_be_immutable

import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimeAndDate extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  TimeAndDate(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<TimeAndDate> createState() => _TimeAndDateState();
}

class _TimeAndDateState extends State<TimeAndDate> {
  List<String> headers = ['Time and Date', 'Checkout', 'Payment'];

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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                          Text('Time and Date',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [...headers.map((e) => _dashList(e)).toList()],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    index == 'Time and Date'
                        ? getCalenderYear()
                        : index == 'Checkout'
                            ? checkOut()
                            : Container()
                  ],
                ),
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
  Widget getCalenderYear() {
    return Expanded(
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
                            size: 19.0,
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
                const SizedBox(height: 10.0,),
                ...DateFormat().dateSymbols.WEEKDAYS.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          radius: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${e[0]}${e[1]}${e[2]}',
                          style: getCustomFont(size: 14.0, color: Colors.black),
                        )
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10.0,),
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
    );
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
  Widget checkOut() => Expanded(
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
                child: Column(
              children: List.generate(2, (index) => bookSummaryItem()),
            )),
            getButton(context, () {
              setState(() {
                index = 'Payment';
              });
            })
          ],
        ),
      );

  bookSummaryItem() => Container(
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

  //-----------------------PAGE 3---------------------------
}
