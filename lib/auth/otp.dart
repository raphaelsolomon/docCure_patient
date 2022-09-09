import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthOtp extends StatefulWidget {
  final Map body;
  const AuthOtp(this.body, {Key? key}) : super(key: key);

  @override
  State<AuthOtp> createState() => _AuthOtpState();
}

class _AuthOtpState extends State<AuthOtp> {
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    size: 20.0,
                  ),
                ),
                Text(
                  'Two-Step Verification',
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
            Image.asset('assets/auth/3.jpeg',
                repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Please enter the OTP (one time password) to verify your account. A code has been sent to this ',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '+1**********179',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getOtpForm(),
                  const SizedBox(
                    width: 8.0,
                  ),
                  getOtpForm(),
                  const SizedBox(
                    width: 8.0,
                  ),
                  getOtpForm(),
                  const SizedBox(
                    width: 8.0,
                  ),
                  getOtpForm(),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(color: BLUECOLOR),
                    ),
                  )
                : getButton(context, () {}, text: 'verify'),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Not received your code? ',
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
                  child: Text('Resend code',
                      style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          color: BLUECOLOR,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            InkWell(
              onTap: () {},
              child: Text('Call me',
                  style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      color: BLUECOLOR,
                      fontWeight: FontWeight.normal)),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ]),
        )));
  }
  String replaceValue(String mail) {
    return mail.replaceAll(new RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), '*');
  }

  String replacePhone(String phoneNumber) {
    return  "(" + phoneNumber.substring(0, 3) + ")" + phoneNumber.substring(3).replaceRange(1, phoneNumber.substring(3).length-2, '****');
  }
}
