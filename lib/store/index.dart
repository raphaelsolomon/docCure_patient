import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/custom_nav.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            color: Color(0xFFf6f6f6),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/imgs/logo.png',
                          width: 150.0, fit: BoxFit.contain),
                      Icon(
                        FontAwesome5.cart_plus,
                        size: 19.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Hello, John Doe',
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Find your medicines',
                    style: getCustomFont(
                        size: 19.0,
                        color: Colors.black,
                        weight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getCardForm('Search medicines'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Shop by catergories',
                            style: getCustomFont(
                                size: 14.0, color: Colors.black45),
                          ),
                        ),
                        Text(
                          'view all',
                          style: getCustomFont(
                              size: 14.0, color: Colors.greenAccent),
                        ),
                      ]),
                  const SizedBox(
                    height: 10.0,
                  ),
                  //List ITEM HERE
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Offers',
                            style: getCustomFont(
                                size: 14.0, color: Colors.black45),
                          ),
                        ),
                        Text(
                          'view all',
                          style: getCustomFont(
                              size: 14.0, color: Colors.greenAccent),
                        ),
                      ]),
                  const SizedBox(
                    height: 10.0,
                  ),
                  //LIST ITEM HERE
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'All Pharmacy stores',
                            style: getCustomFont(
                                size: 14.0, color: Colors.black45),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'All Pharmacy stores',
                            style: getCustomFont(
                                size: 14.0, color: Colors.black45),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 10.0,
                  ),
                ])),
        Align(alignment: Alignment.bottomCenter, child: CustomNavBar(context))
      ],
    );
  }

  Widget getCardForm(hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200),
        child: Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.search,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: TextField(
                style: getCustomFont(size: 14.0, color: Colors.black45),
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: hint,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
