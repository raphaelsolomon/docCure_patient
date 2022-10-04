import 'dart:convert';

import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/referral/referral.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyReferrals extends StatefulWidget {
  MyReferrals({Key? key}) : super(key: key);

  @override
  State<MyReferrals> createState() => _MyReferralsState();
}

class _MyReferralsState extends State<MyReferrals> {
  final refbox = Hive.box(ReferralBox);

  @override
  void initState() {
    super.initState();
  }

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
                  Text('Referral',
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
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(
                    'assets/auth/1.jpeg',
                    width: 200,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: BLUECOLOR,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Your Referral Code',
                          style: getCustomFont(size: 14.0, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${ReferralModel.fromJson(jsonDecode(refbox.get(USERPATH))).data!.referralCode ?? ''}',
                          style: getCustomFont(
                              size: 23.0,
                              color: Colors.white,
                              weight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Refer & Earn',
                        textAlign: TextAlign.center,
                        style: getCustomFont(
                            size: 24.0,
                            color: Colors.black87,
                            weight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Share the referral codes with your friends and family member and get a 2% cashback',
                    textAlign: TextAlign.center,
                    style: getCustomFont(
                        size: 13.0,
                        color: Colors.black45,
                        weight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      social(FontAwesome.facebook, BLUECOLOR, () async {}),
                      social(FontAwesome.whatsapp, Colors.green, () async {
                        await canLaunchUrl(Uri.parse(
                                '${ReferralModel.fromJson(jsonDecode(refbox.get(USERPATH))).data!.whatsappLink}'))
                            ? await launchUrl(Uri.parse(
                                '${ReferralModel.fromJson(jsonDecode(refbox.get(USERPATH))).data!.whatsappLink}'))
                            : print('false');
                      }),
                      social(
                          FontAwesome.twitter, Colors.lightBlueAccent, () {}),
                      social(FontAwesome.google_plus_circle,
                          Colors.red.shade300, () {}),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ))
        ]));
  }

  social(icon, color, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5.0)),
            child: Icon(
              icon,
              color: color,
            )),
      );
}
