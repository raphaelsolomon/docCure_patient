import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/estore_nav.dart';
import 'package:doccure_patient/store/product_lists.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            FontAwesome5.cart_plus,
                            size: 19.0,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Hello, John Doe',
                      style: getCustomFont(size: 14.0, color: Colors.black45, weight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      'Find your medicines',
                      style: getCustomFont(
                          size: 19.0,
                          color: Colors.black,
                          weight: FontWeight.w500),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: getCardForm('Search medicines'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Shop by categories',
                                      style: getCustomFont(
                                          size: 14.0, color: Colors.black45),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      'view all',
                                      style: getCustomFont(
                                          size: 14.0, color: Colors.greenAccent),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 15.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(10, (index) => firstScroll())
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 14.0,
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      'view all',
                                      style: getCustomFont(
                                          size: 14.0, color: Colors.greenAccent),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(10, (index) => secondScroll(context))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Text(
                                        'All Hospital/Clinics',
                                        style: getCustomFont(
                                            size: 14.0, color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 15.0,
                            ),
                            GridView.builder(
                                padding: const EdgeInsets.only(right: 20.0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: returnCrossAxis(width),
                                    mainAxisSpacing: 15.0,
                                    mainAxisExtent: 50.0,
                                    crossAxisSpacing: 20.0),
                                itemCount: 8,
                                itemBuilder: (ctx, i) => thirdScroll(context)),
                            const SizedBox(
                              height: 85.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
          Align(alignment: Alignment.bottomCenter, child: StoreNav(context))
        ],
      ),
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

  Widget firstScroll() => Container(
    width: 150, height: 200,
    padding: const EdgeInsets.all(15.0),
    margin: const EdgeInsets.only(right: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OTC\nMEDICINES', style: getCustomFont(size: 15.0, color: Colors.white),)
      ],
    ),
  );

  Widget secondScroll(context) => Container(
    width: MediaQuery.of(context).size.width / 1.4, height: 110,
    padding: const EdgeInsets.all(15.0),
    margin: const EdgeInsets.only(right: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OTC\nMEDICINES', style: getCustomFont(size: 15.0, color: Colors.white),)
      ],
    ),
  );

  Widget thirdScroll(context) => GestureDetector(
    onTap: () => Get.to(() => ProductList()),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10.0,),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(child: Text('Well Life Store', style: getCustomFont(color: Colors.black, size:14.0, weight: FontWeight.w500),)),
              const SizedBox(height: 1.0,),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black45, size: 12.0,),
                  const SizedBox(width: 5.0,),
                  Flexible(child: FittedBox(child: Text('Willington Bridge', style: getCustomFont(color: Colors.black45, size:12.0, weight: FontWeight.normal),))),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );

  int returnCrossAxis(width) {
    return width < 500
        ? 2
        : width > 500 && width < 100
        ? 2
        : 3;
  }
}
