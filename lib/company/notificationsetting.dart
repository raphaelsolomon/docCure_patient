import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

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
                            onTap: () =>
                                context.read<HomeController>().onBackPress(),
                            child: Icon(Icons.arrow_back_ios,
                                size: 20.0, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Notification Settings',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white),
                    child: Text(
                      'save',
                      style: getCustomFont(size: 11.0, color: BLUECOLOR),
                    ),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                  items('Annoucements', 'Be the first to know about new features and other news', false, true)
              ],
            ),
          ))
        ]));
  }

  Widget items(title, desc, bool b1, bool b2) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getCustomFont(size: 15.0, color: Colors.black),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              desc,
              style: getCustomFont(size: 14.0, color: Colors.black54),
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              children: [
                Row(
                  children: [
                    checkBox(b1),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'On',
                      style: getCustomFont(size: 16.0, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Row(
                  children: [
                    checkBox(b2),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Off',
                      style: getCustomFont(size: 16.0, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            const SizedBox(height: 7.0,),
          ],
        ),
  );

  checkBox(bool b) => Container(
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
          color: !b ? Colors.white : BLUECOLOR,
          border: Border.all(width: 1.0, color: BLUECOLOR)));
}
