import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthRegister extends StatelessWidget {
  const AuthRegister({Key? key}) : super(key: key);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.asset('assets/imgs/register.png',
                            repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          'Register now',
                          style: GoogleFonts.poppins(
                              fontSize: 28.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    getRegisterForm(
                        ctl: null,
                        obscure: false,
                        icon: Icons.person,
                        hint: 'Full Name'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getRegisterForm(
                      ctl: null,
                      icon: Icons.phone,
                      hint: 'Mobile Number',
                      obscure: false,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getRegisterForm(
                        ctl: null,
                        icon: Icons.email_outlined,
                        obscure: false,
                        hint: 'Email Address'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getRegisterForm(
                        ctl: null,
                        icon: Icons.lock_outlined,
                        obscure: true,
                        hint: 'Password'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getRegisterForm(
                        ctl: null,
                        icon: Icons.lock_outlined,
                        obscure: true,
                        hint: 'Confirm Password'),
                    const SizedBox(
                      height: 50.0,
                    ),
                    getButton(context, () {}, text: 'Register'),
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
                              fontWeight: FontWeight.w700),
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
                            'Already have an account?',
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
                          onTap: () => Get.to(() => AuthLogin()),
                          child: Text('Sign In',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: Color(0xFFE72529),
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 46.0,
                    ),
                  ]),
            )));
  }
}
