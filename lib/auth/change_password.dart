import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthChangePass extends StatefulWidget {
  const AuthChangePass({Key? key}) : super(key: key);

  @override
  State<AuthChangePass> createState() => _AuthChangePassState();
}

class _AuthChangePassState extends State<AuthChangePass> {

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 17.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.read<HomeController>().onBackPress(),
                    child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    'Change Password',
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
                getRegisterPasswordForm(
                        ctl: null,
                        hint: 'Old Password',),
              const SizedBox(
                height: 10.0,
              ),
                getRegisterPasswordForm(
                        ctl: null,
                        hint: 'New Password',),
                   const SizedBox(
                height: 10.0,
              ),
                getRegisterPasswordForm(
                        ctl: null,
                        hint: 'Confirm Password',),
              const SizedBox(
                height: 50.0,
              ),
              getButton(context, () {}, text: 'Update Password'),
              const SizedBox(
                height: 30.0,
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
