import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MyReviews extends StatelessWidget {
  const MyReviews({Key? key}) : super(key: key);

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
                      child: Icon(Icons.arrow_back_ios,
                          size: 18.0, color: Colors.white)),
                 
                  Text('Reviews',
                      style:
                          getCustomFont(size: 16.0, color: Colors.white)),
                  InkWell(
                    onTap: () {
                      context.read<HomeController>().setPage(-22);
                    },
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
               const SizedBox(
            height: 15.0,
          ),
            ]),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 0.0),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => getReviews(context)))
        ]));
  }
}
