import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                      horizontal: 20.0, vertical: 17.0),
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
                                  child: Icon(Icons.menu,
                                      color: Colors.white, size: 18.0)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text('Search Doctor',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 16.0))
                            ],
                          ),
                        ),
                        Icon(
                          null,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ]),
                ),
                const SizedBox(
                  height: 118.0,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Specialities',
                              style: getCustomFont(
                                  size: 19.0, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () => null,
                              child: Text(
                                'View All',
                                style: getCustomFont(
                                    size: 15.0, color: Colors.black),
                              ),
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
                                        Container(
                                          width: 68.0,
                                          height: 68.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              boxShadow: SHADOW,
                                              color: Colors.white),
                                          child: Center(
                                              child: Image.asset(
                                            e['asset'],
                                            width: 40.0,
                                            height: 40.0,
                                            fit: BoxFit.contain,
                                          )),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
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
                                  size: 19.0, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () =>
                                  context.read<HomeController>().setPage(-1),
                              child: Text(
                                'View All',
                                style: getCustomFont(
                                    size: 15.0, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(3, (index) => findDoctors())
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              ...Advert.map((e) => advert(e)).toList()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 90.0,
                      ),
                    ],
                  ),
                )),
              ],
            ),
            Positioned(
              top: 82.0,
              right: 0,
              left: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160.0,
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
          getButton(context, () {
            context.read<HomeController>().setPage(-3);
          }, color: Colors.red)
        ],
      );

  Widget advert(e) => Container(
        width: MediaQuery.of(context).size.width - 90,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey.shade200),
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(80.0)),
                  color: BLUECOLOR),
              child: Text(
                e['title'],
                style: getCustomFont(
                    color: Colors.white, size: 26.0, weight: FontWeight.bold),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e['desc'],
                      style: getCustomFont(
                          color: Colors.black54,
                          size: 16.0,
                          weight: FontWeight.bold)),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'know more',
                        style: getCustomFont(
                            color: BLUECOLOR,
                            size: 15.0,
                            weight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
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

  Widget getButton(context, callBack,
          {color = BLUECOLOR, text = 'Search Now'}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      );

  Widget getProfileButton(context, callBack, {text = 'View Profile'}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0, color: BLUECOLOR),
              borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                maxLines: 1,
                style: GoogleFonts.poppins(
                    fontSize: 13.0,
                    color: BLUECOLOR,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );

  Widget findDoctors() => Container(
        width: MediaQuery.of(context).size.width - 29,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 1.0))
        ], color: Colors.white, borderRadius: BorderRadius.circular(13.0)),
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
                        Flexible(
                          child: Row(
                            children: [
                              PhysicalModel(
                                elevation: 10.0,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                                shadowColor: Colors.grey,
                                child: SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: Icon(
                                    FontAwesome5.teeth,
                                    size: 11.0,
                                    color: Color(0xFF838383),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Dentist',
                                style: GoogleFonts.poppins(
                                    color: Colors.lightBlue,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
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
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15.0,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '(47)',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 14.0,
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
                  ],
                )),
                Icon(
                  Icons.bookmark_outline,
                  size: 18.0,
                  color: BLUECOLOR,
                )
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Divider(),
            const SizedBox(
              height: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
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
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Flexible(
                  child: getProfileButton(context, () {
                    context.read<HomeController>().setPage(-4);
                  }),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: getButton(context, () {
                    context.read<HomeController>().setPage(-1);
                  }, text: 'Book Appointment'),
                )
              ],
            )
          ],
        ),
      );
}
