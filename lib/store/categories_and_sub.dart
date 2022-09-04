import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';

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
                             
                                child: Icon(
                                  null,
                                  color: Colors.white,
                                  size: 19.0,
                                )),
                            Text('Categories',
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
                  child: GridView.builder(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: returnCrossAxis(
                              MediaQuery.of(context).size.width),
                          mainAxisSpacing: 15.0,
                          mainAxisExtent: 90.0,
                          crossAxisSpacing: 20.0),
                      itemCount: 8,
                      itemBuilder: (ctx, i) => Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                image: DecorationImage(
                                    image: AssetImage('assets/imgs/4.png'),
                                    fit: BoxFit.cover)),
                            child: Center(
                              child: Text(
                                'Antibiotics',
                                style: getCustomFont(
                                    color: Colors.white,
                                    weight: FontWeight.w500),
                              ),
                            ),
                          )))
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
