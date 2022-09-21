import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesAndSub extends StatelessWidget {
  const CategoriesAndSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFf6f6f6),
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: BLUECOLOR,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 19.0,
                                )),
                            Text('Shop By Category',
                                style: getCustomFont(
                                    size: 17.0, color: Colors.white)),
                            Icon(
                              null,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                  child: Row(
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(
                            7,
                            (index) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 140.0,
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.0),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/imgs/4.png'),
                                          fit: BoxFit.cover)),
                                  child: Center(
                                    child: Text(
                                      'Antibiotics',
                                      style: getCustomFont(
                                          color: Colors.white,
                                          weight: FontWeight.w500),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 13.0,
                  ),
                  Flexible(
                      flex: 3,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              boxShadow: SHADOW,
                              borderRadius: BorderRadius.circular(13.0),
                              color: Colors.white))),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ))
            ])));
  }

  int returnCrossAxis(width) {
    return width < 500
        ? 2
        : width > 500 && width < 100
            ? 2
            : 3;
  }
}
