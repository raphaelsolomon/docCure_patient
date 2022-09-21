import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialMedia extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  SocialMedia(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  List socials = [
    {'title': 'Facebook', 'image': 'assets/imgs/facebook.png'},
    {'title': 'Twitter', 'image': 'assets/imgs/twitter.png'},
    {'title': 'Google Plus', 'image': 'assets/imgs/google-plus.png'},
    {'title': 'LinkedIn', 'image': 'assets/imgs/linkedin.png'},
    {'title': 'Instagram', 'image': 'assets/imgs/instagram.png'}
  ];

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
                  Text('Social Media',
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
                  padding: const EdgeInsets.all(0.0),
                  itemCount: socials.length,
                  itemBuilder: (ctx, i) => Container(
                        decoration: BoxDecoration(
                            boxShadow: SHADOW,
                            borderRadius: BorderRadius.circular(13.0),
                            color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage(socials[i]['image']),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '${socials[i]['title']}',
                                  style: getCustomFont(
                                      size: 14.0, color: Colors.black),
                                )
                              ]),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 19.0,
                            )
                          ],
                        ),
                      )))
        ]));
  }
}
