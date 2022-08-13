import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthOtp extends StatelessWidget {
  const AuthOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            const SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Verify Your Number',
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
              height: 20.0,
            ),
            Image.asset('assets/imgs/register.png',
                repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Enter 4 digit verification code sent on your phone',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getOtpForm(),
                  getOtpForm(),
                  getOtpForm(),
                  getOtpForm(),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            getButton(context, () {}, text: 'Proceed'),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Didn’t receive otp?',
                    style: GoogleFonts.poppins(
                        fontSize: 15.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  width: 3.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Text('Resend',
                      style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          color: Color(0xFFE72529),
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
          ]),
        )));
  }
}
