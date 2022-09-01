import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Prescriptions extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const Prescriptions(this.scaffold, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            height: 86.0,
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
                            onTap: () => scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('My Prescriptions',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<HomeController>().setPage(12);
                    },
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(height: 10.0,),
          Expanded(child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: ((context, index) => prescriptionItem(context))))
        ]));
  }

     Widget prescriptionItem(context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  'Prescription 1',
                  style: getCustomFont(
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  '14 Mar 2022',
                  style: getCustomFont(
                      size: 15.0,
                      color: Colors.black45,
                      weight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ruby Perrln',
                      style: getCustomFont(
                          color: Colors.black,
                          size: 19.0,
                          weight: FontWeight.w400),
                    ),
                    Text(
                      'Dental',
                      style: getCustomFont(
                          color: Colors.black54,
                          size: 14.0,
                          weight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        getButton(context, () {},
                            color: Colors.lightGreen.shade300),
                        const SizedBox(
                          width: 10.0,
                        ),
                        getButton(context, () {},
                            icon: Icons.print,
                            text: 'Print',
                            color: Colors.grey),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }

  Widget getButton(context, callBack,
          {text = 'View',
          icon = Icons.remove_red_eye,
          color = Colors.lightBlueAccent}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 14.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Text(
                  '$text',
                  style: getCustomFont(
                      size: 14.0,
                      color: Colors.white,
                      weight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );
}
