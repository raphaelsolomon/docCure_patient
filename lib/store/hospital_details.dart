import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/store/store_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalDetails extends StatefulWidget {
  const HospitalDetails({super.key});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  int counter = 0;

  List<String> tabs = ['Abouts', 'Departments', 'Services'];
  String selectedTab = 'Abouts';
  int totalFacility = 6;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              width: width,
              height: 250.0,
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) => setState(() {
                            counter = value;
                          }),
                      itemBuilder: ((context, index) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/imgs/3.png'),
                                    fit: BoxFit.cover)),
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 43.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 19.0,
                              color: Colors.white,
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.bookmark_outline,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...List.generate(
                              3, (index) => dotIndicator(counter, index))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apple Hospital',
                    style: getCustomFont(
                        size: 19.0,
                        color: Colors.black,
                        weight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'General Hospital',
                    style: getCustomFont(
                        size: 14.0,
                        color: Colors.black45,
                        weight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...tabs.map(
                          (e) => GestureDetector(
                            onTap: () => setState(() {
                              selectedTab = e;
                            }),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                '$e',
                                style: getCustomFont(
                                    size: 15.0,
                                    color: selectedTab == e
                                        ? BLUECOLOR
                                        : Colors.black,
                                    weight: selectedTab == e
                                        ? FontWeight.w600
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
                child: selectedTab == 'Abouts'
                    ? getAboutPage(totalFacility, width, _controller)
                    : selectedTab == 'Departments'
                        ? getDepartment()
                        : getServices()),
            Row(
              children: [
                Flexible(
                  child: Container(
                    width: width,
                    height: 50.0,
                    color: BLUECOLOR,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 19.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Call Now',
                          style: getCustomFont(size: 13.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1.0,
                ),
                Flexible(
                  child: Container(
                    width: width,
                    height: 50.0,
                    color: BLUECOLOR,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                          size: 19.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Chat Now',
                          style: getCustomFont(size: 13.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget dotIndicator(total, i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: total == i ? BLUECOLOR : BLUECOLOR.withOpacity(.3),
          radius: 3.5,
        ),
        const SizedBox(
          width: 5.0,
        ),
      ],
    );
  }
}
