import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const MyOrder(this.scaffold, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text('Orders',
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
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => orderItem(context)))
        ]));
  }

  Widget orderItem(context) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Orrder ID : ',
                style: getCustomFont(size: 15.0, color: Colors.black)),
            Text('9', style: getCustomFont(size: 15.0, color: Colors.black)),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Column(
              children: [
                Text('Pending',
                    style: getCustomFont(size: 13.0, color: Colors.amber)),
                Text('2022-05-06',
                    style: getCustomFont(size: 13.0, color: Colors.black)),
              ],
            ),
            Flexible(child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: BLUECOLOR
                ),
                child: Text('Cancel', style: getCustomFont(color: Colors.white, size: 13.0,)),),
                const SizedBox(width: 10.0,),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: BLUECOLOR
                ),
                child: Text('Info', style: getCustomFont(color: Colors.white, size: 13.0,)),)
            ],))
          ],
        ),
      ]));
}
