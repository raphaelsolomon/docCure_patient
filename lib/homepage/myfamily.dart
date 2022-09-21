import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFamily extends StatefulWidget {
  const MyFamily({Key? key}) : super(key: key);

  @override
  State<MyFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  var family = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFf6f6f6),
            child: Column(children: [
                Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            width: MediaQuery.of(context).size.width,
            color: BLUECOLOR,
            child: Column(children: [
              const SizedBox(
                height: 45.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => context.read<HomeController>().onBackPress(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18.0,
                      )),
                  Text('Family',
                      style: getCustomFont(color: Colors.white, size: 16.0)),
                  Icon(
                    null,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
            ]),
          ),
              Expanded(
                  child: family.isEmpty
                      ? emptyContainer(context)
                      : ListView.builder(
                          itemCount: 10,
                          padding: const EdgeInsets.all(0.0),
                          itemBuilder: (ctx, i) => listItem()))
                          
            ])),
        Visibility(
          visible: family.isNotEmpty,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                child: Icon(Icons.add, color: Colors.white,),
                backgroundColor: BLUECOLOR,
                radius: 30.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  listItem() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Row(children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(width: 2.0, color: BLUECOLOR)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                'assets/imgs/1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe Williams',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                ),
                Text(
                  '70 years old',
                  style: getCustomFont(size: 17.0, color: Colors.black45),
                ),
              ],
            ),
          ),
          Icon(
            Icons.family_restroom,
            color: BLUECOLOR,
            size: 18.0,
          )
        ]),
      );

  emptyContainer(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_home_sharp,
              size: 79.0,
              color: BLUECOLOR,
            ),
            Text(
              'You have not created a family',
              style: getCustomFont(size: 17.0, color: Colors.black54),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Family member can pay for services and medications from one linked wallet.',
              textAlign: TextAlign.center,
              style: getCustomFont(color: Colors.black45, size: 14.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                dialogMessage(context, familyPop(context));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: BLUECOLOR),
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0, vertical: 11.0),
                child: Text(
                  'Create a family',
                  style: getCustomFont(size: 15.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
}
