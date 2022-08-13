import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FindDoctorsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const FindDoctorsPage(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<FindDoctorsPage> createState() => _FindDoctorsPageState();
}

class _FindDoctorsPageState extends State<FindDoctorsPage> {
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
                                  onTap: () => widget.scaffold.currentState!
                                      .openDrawer(),
                                  child: Icon(Icons.menu, color: Colors.white)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('Find Doctor',
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
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Specialities',
                              style: getCustomFont(
                                  size: 22.0, color: Colors.black),
                            ),
                            Text(
                              'View All',
                              style: getCustomFont(
                                  size: 17.0, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                ...Specialities.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(FontAwesome5.heart, color: Colors.black54, size: 20.0,),
                                          radius: 33.0,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          e['title'],
                                          style: getCustomFont(
                                              size: 14.0, color: Colors.black),
                                        )
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Find Doctors',
                              style: getCustomFont(
                                  size: 22.0, color: Colors.black),
                            ),
                            Text(
                              'View All',
                              style: getCustomFont(
                                  size: 17.0, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ...List.generate(3, (index) => findDoctors())
                    ],
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
                  height: 170.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
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
                  child: getDoctors()),
            )
          ],
        ));
  }

  Widget getDoctors() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Stack(
            children: [
              SearchField(
                  Icons.location_on, 'Search Location (Ex: Chennai etc)'),
              Positioned(
                  top: 40.0,
                  left: 18.0,
                  child: Text(
                    '|',
                    style: GoogleFonts.poppins(color: Colors.black54),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: SearchField(
                    Icons.local_hospital, 'GKN Hospital, Bangalore'),
              ),
            ],
          )),
          const SizedBox(
            height: 10.0,
          ),
          getButton(context, () {})
        ],
      );

  Widget SearchField(icon, label) => Row(
        children: [
          PhysicalModel(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            shadowColor: Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(
                icon,
                size: 18.0,
                color: Color(0xFF838383),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: TextFormField(
                cursorColor: BLUECOLOR,
                style:
                    GoogleFonts.poppins(fontSize: 14.0, color: Colors.black54),
                decoration: InputDecoration(
                  focusColor: Colors.black54,
                  contentPadding:
                      const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                  hintText: '$label',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14.0, color: Colors.black54),
                )),
          )
        ],
      );

  Widget getButton(context, callBack, {text = 'Search Now'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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

  Widget findDoctors() => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 1.0))
        ], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/imgs/2.png',
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 13.0,
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ruby Perrln',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'MDS - periodontology, BDS',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dentist',
                          style: GoogleFonts.poppins(
                              color: Colors.lightBlue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '9+ Exp',
                          style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '(47)',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 15.0,
                            ),
                            Text(
                              'Florida, USA',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Divider(),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PhysicalModel(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: Icon(
                          Icons.thumb_up,
                          size: 12.0,
                          color: Color(0xFF838383),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      '98%',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    PhysicalModel(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: Icon(
                          Icons.money,
                          size: 12.0,
                          color: Color(0xFF838383),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      '\$300 - \$1000',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            getButton(context, (){
              context.read<HomeController>().setPage(-1);
            }, text: 'Book Appointment'),
          ],
        ),
      );
}
