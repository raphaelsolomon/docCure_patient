import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RateUS extends StatelessWidget {
  const RateUS({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 GestureDetector(
                            onTap: () =>
                                context.read<HomeController>().onBackPress(),
                            child: Icon(Icons.arrow_back_ios,
                                size: 20.0, color: Colors.white)),
                       
                        Text('Rate Us',
                            style: getCustomFont(
                                size: 18.0, color: Colors.white)),
                  Icon(
                    null,
                    color: Colors.white,
                  )
                ],
              )
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
                  Text(
                    'How was your experience',
                    textAlign: TextAlign.center,
                    style: getCustomFont(
                        size: 23.0, color: Colors.black, weight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: BLUECOLOR,
                      size: 15.0,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  getFormSubscribe(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  getButton(context, () {}, 'Submit Feedback'),
                  const SizedBox(
                    height: 20.0,
                  ),
                            ],
                          ),
                ),
              ))
        ]));
  }

  Widget getButton(context, callBack, text,
          {textColor = Colors.white, bgColor = BLUECOLOR}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(100.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '$text',
                style: getCustomFont(
                    size: 18.0, color: textColor, weight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );

  getFormSubscribe({ctl}) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey.shade200),
        child: TextField(
          maxLines: 10,
          controller: ctl,
          keyboardType: TextInputType.multiline,
          style: getCustomFont(size: 16.0, color: Colors.black54),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              hintText: 'write your experience here',
              hintStyle: getCustomFont(size: 16.0, color: Colors.black54),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      );
}
