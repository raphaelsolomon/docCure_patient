import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset('assets/imgs/logo.png',
                  repeat: ImageRepeat.noRepeat, fit: BoxFit.contain),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    'Sign In to your Account',
                    style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        color: BLUECOLOR,
                        fontWeight: FontWeight.w700),
                  ))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              getRegisterForm(
                  ctl: null, obscure: false, hint: 'Email or username'),
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
                    child: Text(
                      'Forgotten Password?',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0, color: Colors.black45),
                    ),
                  ),
                ),
              ),
              getButton(context, () {}),
              const SizedBox(
                height: 26.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    'Don\'t have an login ?',
                    style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.normal),
                  )),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text('Signup Now!',
                      style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal))
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 74,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 53,
                              padding: const EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2F5597),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 5.0),
                                child: Text(
                                  'Facebook',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.0),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18.0,
                            bottom: 28.0,
                            child: PhysicalModel(
                              color: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 10.0,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.0),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.facebook_outlined,
                                    color: Color(0xFF2F5597)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 74,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 53,
                              padding: const EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDD4B39),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, top: 5.0),
                                child: Text(
                                  'Google',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.0),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18.0,
                            bottom: 28.0,
                            child: PhysicalModel(
                              color: Colors.white,
                              elevation: 10.0,
                              shadowColor: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.0),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.facebook_outlined,
                                    color: Color(0xFFDD4B39)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60.0,
              )
            ],
          ),
        ),
      )),
    );
  }
}
