import 'package:doccure_patient/auth/otp.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForgotPass extends StatelessWidget {
  const AuthForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 17.0,),
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
                    'Forgot Password',
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
                'Enter your Registered email address to receive your password reset code',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 50.0,
              ),
              getRegisterForm(ctl: null, obscure: false, hint: 'Email Address'),
              const SizedBox(
                height: 50.0,
              ),
              getButton(context, () {}, text: 'Reset Password'),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () => Get.to(() => AuthOtp()),
                child: Text(
                  'Back to login',
                  style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: BLUECOLOR,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
