import 'dart:convert';
import 'dart:io';

import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;

import '../model/person/user.dart';

class ResetPassword extends StatefulWidget {
  final String username;
  const ResetPassword(this.username, {Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isloading = false;
  final token = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  final box = Hive.box<User>(BoxName);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F6F6),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            color: BLUECOLOR,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.read<HomeController>().onBackPress(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                Text(
                  'Change Password',
                  style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Icon(
                  null,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Image.asset('assets/auth/change_pass.png', repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   'Enter your Registered email address to receive your password reset code',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.poppins(
                  //       fontSize: 14.0,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400),
                  // ),
                  // const SizedBox(
                  //   height: 50.0,
                  // ),
                  getRegisterForm(
                    ctl: token,
                    hint: 'Token',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getRegisterPasswordForm(
                    ctl: newPass,
                    hint: 'New Password',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  getRegisterPasswordForm(
                    ctl: confirmPass,
                    hint: 'Confirm Password',
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  isloading ? SizedBox(width: MediaQuery.of(context).size.width, child: Center(child: CircularProgressIndicator())) : getButton(context, () => onExecute(), text: 'Update Password'),
                  const SizedBox(
                    height: 30.0,
                  ),

                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void onExecute() async {
    if (token.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Token required'));
      return;
    }

    if (newPass.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'New password required'));
      return;
    }

    if (confirmPass.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Confirm password required'));
      return;
    }

    if (newPass.text.trim() != newPass.text.trim()) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Password does not match'));
      return;
    }

    setState(() {
      isloading = true;
    });

    try {
      var request = http.Request('POST', Uri.parse('${ROOTAPI}/api/v1/reset/password'));
      if (widget.username.isEmail)
        request.body = json.encode({"token": token.text.trim(), "password": newPass.text.trim(), 'password_confirmation': confirmPass.text.trim(), "email": widget.username});
      else
        request.body = json.encode({"token": token.text.trim(), "password": newPass.text.trim(), 'password_confirmation': confirmPass.text.trim(), "phone_number": widget.username});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        response.stream.bytesToString().then((value) {
          final parsed = json.decode(value);
          setState(() {
            isloading = false;
          });
          popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, parsed['message'], status: true));
        });
      } else {
        setState(() {
          isloading = false;
        });
        popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
      }
    } on SocketException {
      setState(() {
        isloading = false;
      });
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Check Internet Connection', status: false));
    } finally {
      setState(() {
        token.clear();
        newPass.clear();
        confirmPass.clear();
      });
    }
  }
}
