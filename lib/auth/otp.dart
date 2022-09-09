import 'dart:convert';
import 'dart:io';

import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;

class AuthOtp extends StatefulWidget {
  final String body;
  const AuthOtp(this.body, {Key? key}) : super(key: key);

  @override
  State<AuthOtp> createState() => _AuthOtpState();
}

class _AuthOtpState extends State<AuthOtp> {
  bool isLoading = false;
  bool isResending = false;
  var listOTp = [];
  final otp1 = TextEditingController();
  final node1 = FocusNode();
  final otp2 = TextEditingController();
  final node2 = FocusNode();
  final otp3 = TextEditingController();
  final node3 = FocusNode();
  final otp4 = TextEditingController();
  final node4 = FocusNode();

  @override
  void initState() {
    node1.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        resizeToAvoidBottomInset: false,
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
                    size: 19.0,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    widget.body.isEmail
                        ? replaceValue(widget.body)
                        : replacePhone(widget.body),
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
                        getOtpForm(
                            ctl: otp1,
                            node: node1,
                            onChange: (s) {
                              listOTp[0] = s;
                              node2.requestFocus();
                            }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        getOtpForm(
                            ctl: otp2,
                            node: node2,
                            onChange: (s) {
                              listOTp[1] = s;
                              node3.requestFocus();
                            }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        getOtpForm(
                            ctl: otp3,
                            node: node3,
                            onChange: (s) {
                              listOTp[2] = s;
                              node4.requestFocus();
                            }),
                        const SizedBox(
                          width: 8.0,
                        ),
                        getOtpForm(
                            ctl: otp4,
                            node: node4,
                            onChange: (s) {
                              listOTp[3] = s;
                            }),
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
                      : getButton(context, () {
                          validDate();
                        }, text: 'verify'),
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
                              fontSize: 14.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      isResending
                          ? Text('Resending',
                              style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: BLUECOLOR.withOpacity(.5),
                                  fontWeight: FontWeight.normal))
                          : InkWell(
                              onTap: () {
                                resendCode();
                              },
                              child: Text('Resend code',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: BLUECOLOR,
                                      fontWeight: FontWeight.normal)),
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text('Call me',
                        style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: BLUECOLOR,
                            fontWeight: FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ]),
              ),
            )
          ]),
        )));
  }

  void validDate() async {
    if (listOTp.length < 4) {
      popupMessage.dialogMessage(
          context, popupMessage.serviceMessage(context, 'Input not valid'));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final res = await http.post(Uri.parse('${ROOTAPI}/api/user/email/verify'),
          body: {'email': widget.body.trim(), 'otp': listOTp.join('')});
      if (res.statusCode == 200) {
        final parsed = jsonDecode(res.body);
        popupMessage.dialogMessage(
            context,
            popupMessage.serviceMessage(context, parsed['message'],
                status: true, cB: () {
              Get.to(() => AuthLogin());
            }),
            barrierDismiss: false);
      } else {
        final parsed = jsonDecode(res.body);
        popupMessage.dialogMessage(
            context,
            popupMessage.serviceMessage(context, parsed['message'],
                status: false));
      }
    } on SocketException {
      popupMessage.dialogMessage(
          context,
          popupMessage.serviceMessage(
              context, 'Plase check internect connection',
              status: false));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void resendCode() async {
    setState(() => isResending = true);
    try {
      final res = await http.post(Uri.parse('${ROOTAPI}/api/user/otp/resend'),
          body: {'email': widget.body.trim()});
      if (res.statusCode == 200) {
        final parsed = jsonDecode(res.body);
        popupMessage.dialogMessage(
            context,
            popupMessage.serviceMessage(context, parsed['message'],
                status: true, cB: () {}),
            barrierDismiss: false);
      } else {
        final parsed = jsonDecode(res.body);
        popupMessage.dialogMessage(
            context,
            popupMessage.serviceMessage(context, parsed['message'],
                status: false));
      }
      setState(() => isResending = false);
    } on SocketException {
      setState(() => isResending = false);
      popupMessage.dialogMessage(
          context,
          popupMessage.serviceMessage(
              context, 'Plase check internect connection',
              status: false));
    }
  }

  String replaceValue(String mail) {
    return mail.replaceAll(new RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), '*');
  }

  String replacePhone(String phoneNumber) {
    return "(" +
        phoneNumber.substring(0, 3) +
        ")" +
        phoneNumber
            .substring(3)
            .replaceRange(1, phoneNumber.substring(3).length - 2, '****');
  }
}
