import 'package:doccure_patient/auth/forgotpass.dart';
import 'package:doccure_patient/auth/register.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/homepage/dashboard.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  bool isEmail = true;
  late final phoneController;

  @override
  void initState() {
    phoneController = PhoneController(null);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      phoneController.addListener(() => setState(() {}));
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset('assets/imgs/register.png',
                  repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                        fontSize: 28.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ))
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in your account to continue',
                    style: GoogleFonts.poppins(
                        fontSize: 13.0, color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  optionButton(context)
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              isEmail
                  ? getRegisterForm(
                      ctl: null, obscure: false, hint: 'Email or username')
                  : getPhoneNumberForm(
                      ctl: phoneController),
              const SizedBox(
                height: 20.0,
              ),
              getRegisterForm(
                  ctl: null, obscure: true, hint: 'Password', icon: Icons.lock),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Get.to(() => AuthForgotPass()),
                      child: Text(
                        'Forgotten Password?',
                        style: GoogleFonts.poppins(
                            fontSize: 14.5, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              getButton(context, () => Get.to(() => DashBoard())),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: const Divider(
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    'Or Sign in using',
                    style: GoogleFonts.poppins(
                        fontSize: 13.0,
                        color: Color(0xFF838391),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 15.0),
                  Flexible(
                    child: const Divider(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  socialAccount(FontAwesome.facebook, Color(0xFF1777F2),
                      callBack: () {}),
                  socialAccount(FontAwesome.linkedin, Color(0xFF0078B5),
                      callBack: () {}),
                  socialAccount(FontAwesome.google, Colors.redAccent,
                      callBack: () {}),
                ],
              ),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Don\'t have an account?',
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
                    onTap: () => Get.to(() => AuthRegister()),
                    child: Text('Register',
                        style: GoogleFonts.poppins(
                            fontSize: 15.0,
                            color: Color(0xFFE72529),
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              const SizedBox(
                height: 46.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionButton(context) => Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() => isEmail = true),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: isEmail ? BLUECOLOR : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'with Email Address',
                    style: GoogleFonts.poppins(
                        color: isEmail ? Colors.white : BLUECOLOR),
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => setState(() => isEmail = false),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: !isEmail ? BLUECOLOR : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'with Phone Number',
                    style: GoogleFonts.poppins(
                        color: !isEmail ? Colors.white : BLUECOLOR),
                  )),
                ),
              ),
            ),
          ),
        ],
      );
}
