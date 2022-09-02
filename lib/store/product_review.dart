import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({Key? key}) : super(key: key);

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
                      height: 10.0,
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
                          Text('Reviews',
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
                    // getRegisterForm(
                    //     ctl: null,
                    //     hint: 'Search for categories',
                    //     icon: Icons.search,
                    //     height: 49.0),
                    // const SizedBox(
                    //   height: 13.0,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text('Silospir 100mg Tablet', style: getCustomFont(size: 15.0, color: Colors.black, weight: FontWeight.w500),)),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 19.0,),
                                  Text('4.5', style: getCustomFont(size: 14.0, color: Colors.amber, weight: FontWeight.w500),),
                                ],
                              ),
                            ],),
                          const SizedBox(height: 5.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text('Average Reviews', style: getCustomFont(size: 13.0, color: Colors.black45, weight: FontWeight.w400),)),
                              Flexible(child: GestureDetector(
                                  onTap: () => Get.to(() => ProductReview()),
                                  child: Text('Avg. reviews', style: getCustomFont(size: 13.0, color: Colors.black45, weight: FontWeight.w400),))),
                            ],),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ])),
    );
  }
}
