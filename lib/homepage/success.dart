import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BLUECOLOR,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      Text(
                        '',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        null,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Image.asset('assets/imgs/success.png', width: 100.0, height: 100.0,),
                  const SizedBox(
                    height: 50.0,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    dashPattern: [8, 4],
                    strokeCap: StrokeCap.butt,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Column(children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Appointment Booked Successfully!',
                            textAlign: TextAlign.center,
                            style:
                                getCustomFont(size: 23.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Appointment booked with ',
                            textAlign: TextAlign.center,
                            style:
                                getCustomFont(size: 16.0, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dr. Darren Elder',
                                textAlign: TextAlign.center,
                                style: getCustomFont(
                                    size: 16.0, color: Colors.amber),
                              ),
                              Text(
                                ' on ',
                                textAlign: TextAlign.center,
                                style: getCustomFont(
                                    size: 17.0, color: Colors.white),
                              ),
                              Text(
                                ' 12 Nov 2019',
                                textAlign: TextAlign.center,
                                style: getCustomFont(
                                    size: 16.0, color: Colors.amber),
                              ),
                            ],
                          ),
                          Text(
                            '5:00 PM to 6:00 PM',
                            textAlign: TextAlign.center,
                            style:
                                getCustomFont(size: 16.0, color: Colors.amber),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ]),
                      ),
                    ),
                  ),
                   const SizedBox(
                    height: 50.0,
                  ),
                  getButton(context, () {}, text: 'View Invoice', textcolor: Colors.black, color: Colors.white)
                ]))));
  }
}
