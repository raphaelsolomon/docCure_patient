import 'package:doccure_patient/resuable/estore_nav.dart';
import 'package:doccure_patient/store/categories_and_sub.dart';
import 'package:doccure_patient/store/store_dashboard.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int index = 0;
  String page = 'Overview';
  List<String> headers = [
    'Overview',
    'Appointments',
    'Prescriptions',
    'Medical Records',
    'Billing'
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 0.0, top: 0.0),
              color: Color(0xFFf6f6f6),
              child: index == 0
                  ? getDashboard(context, width)
                  : index == 2
                      ? getHospital(context)
                      : index == 3
                          ? CategoriesAndSub()
                          : getProfile(page, context, () {}, headers,
                              dash: (e) {
                              setState(() {
                                page = e;
                              });
                            })),
          Align(
              alignment: Alignment.bottomCenter,
              child: StoreNav(context, (i) {
                setState(() {
                  index = i;
                });
              }, index))
        ],
      ),
    );
  }
}
