import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDoctor extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const SearchDoctor(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
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
                        Text('Search by Doctor',
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
          Container(
            padding: const EdgeInsets.all(10.0),
            width: width,
            height: 120,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(6, (index) => horizontalScroll())
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '16525 matches found for :',
                  style: getCustomFont(size: 14.0, color: Colors.black54),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  'Dental specialist In Bangalore',
                  style: getCustomFont(size: 19.0, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemBuilder: (ctx, i) => findDoctors()))
        ]));
  }

  Widget horizontalScroll() =>Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100.0),
      border: Border.all(color: Colors.black45, width: 1.0)
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 15.0,
          child: Icon(Icons.star, color: Colors.amber, size: 15.0,),
        ),
        const SizedBox(width: 3.0,),
        Text('Stethoscope', style: getCustomFont(size: 15.0, color: Colors.black45),)
      ],
    ),
  );

  Widget findDoctors() => Container(
        width: MediaQuery.of(context).size.width,
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
                      style: getCustomFont(
                          color: Colors.black,
                          size: 15.0,
                          weight: FontWeight.w600),
                    ),
                    Text(
                      'MDS - periodontology, BDS',
                      style: getCustomFont(
                          color: Colors.black,
                          size: 14.0,
                          weight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dentist',
                          style: getCustomFont(
                              color: Colors.lightBlue,
                              size: 14.0,
                              weight: FontWeight.w400),
                        ),
                        Text(
                          '9+ Exp',
                          style: getCustomFont(
                              color: Colors.redAccent,
                              size: 14.0,
                              weight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '(47)',
                          style: getCustomFont(
                              color: Colors.black,
                              size: 13.0,
                              weight: FontWeight.w400),
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
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 16.0,
                                  weight: FontWeight.w400),
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
              height: 2.0,
            ),
            Divider(),
            const SizedBox(
              height: 2.0,
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
                      style: getCustomFont(
                          color: Colors.black,
                          size: 16.0,
                          weight: FontWeight.w400),
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
                      style: getCustomFont(
                          color: Colors.black,
                          size: 16.0,
                          weight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            getButton(context, () {
              context.read<HomeController>().setPage(-1);
            }, text: 'Book Appointment'),
          ],
        ),
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
                style: getCustomFont(
                    size: 17.0, color: Colors.white, weight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );
}
