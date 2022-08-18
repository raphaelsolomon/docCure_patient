import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AuthRegister extends StatefulWidget {
  const AuthRegister({Key? key}) : super(key: key);

  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  late PhoneController phoneController;
  bool isEmail = true;
  String country = 'Nigeria';

  @override
  void initState() {
    phoneController = PhoneController(null);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      phoneController.addListener(() => setState(() {
            var i = countryList.indexWhere((element) =>
                element['code'] == '${phoneController.value!.isoCode.name}');
            country = countryList.elementAt(i)['name'];
          }));
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
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          'Get Started For Free',
                          style: GoogleFonts.poppins(
                              fontSize: 28.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ))
                      ],
                    ),
                    Text(
                      'Sign-up to your account to continue',
                      style: GoogleFonts.poppins(
                          fontSize: 13.0, color: Colors.black45),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    optionButton(context),
                    const SizedBox(
                      height: 15.0,
                    ),
                    getRegisterForm(
                        ctl: null,
                        obscure: false,
                        icon: Icons.person,
                        hint: 'Full Name'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    isEmail
                        ? getRegisterForm(
                            ctl: null,
                            icon: Icons.email_outlined,
                            obscure: false,
                            hint: 'Email Address')
                        : getPhoneNumberForm(ctl: phoneController),
                    const SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () =>  showBottomSheet() ,
                      child: getCountryForm(text: country),
                    ),
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
                        hint: 'Confirm Password',
                        cp: ''),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialAccount(FontAwesome.facebook, Color(0xFF1777F2),
                            callBack: () {}),
                            const SizedBox(width: 20.0,),
                        socialAccount(FontAwesome.linkedin, Color(0xFF0078B5),
                            callBack: () {}),
                            const SizedBox(width: 20.0,),
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
                                  fontSize: 16.0,
                                  color: BLUECOLOR,
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

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Select Country',
              style: GoogleFonts.poppins(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                          countryList.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        country = '${countryList[index]['name']}';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '${countryList[index]['name']}',
                                        style: getCustomFont(
                                            size: 16.0, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ))),
                ),
              ),
            )
          ],
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
                    'with Mobile Number',
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
