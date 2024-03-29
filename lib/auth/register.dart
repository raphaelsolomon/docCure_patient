import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/auth/otp.dart';
import 'package:doccure_patient/homepage/dashboard.dart';
import 'package:doccure_patient/resources/firebase_method.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;
import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:linkedin_login/linkedin_login.dart';
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
  String country_id = '161';
  bool isLoading = false;
  final firstname = TextEditingController();
  final lasttname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void initState() {
    phoneController = PhoneController(null);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      phoneController.addListener(() => setState(() {
            var i = countryList.indexWhere((element) => '+${element['code']}' == '${phoneController.value!.isoCode}');
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
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 45.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image.asset('assets/auth/1.jpeg', repeat: ImageRepeat.noRepeat, fit: BoxFit.contain, height: 250),
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
                      style: GoogleFonts.poppins(fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.w700),
                    ))
                  ],
                ),
                Text(
                  'Sign-up to your account to continue',
                  style: GoogleFonts.poppins(fontSize: 13.0, color: Colors.black45),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                optionButton(context),
                const SizedBox(
                  height: 15.0,
                ),
                getRegisterForm(ctl: firstname, obscure: false, icon: Icons.person, hint: 'First Name'),
                const SizedBox(
                  height: 10.0,
                ),
                getRegisterForm(ctl: lasttname, obscure: false, icon: Icons.person, hint: 'Last Name'),
                const SizedBox(
                  height: 10.0,
                ),
                isEmail ? getRegisterForm(ctl: email, icon: Icons.email_outlined, obscure: false, hint: 'Email Address') : getPhoneNumberForm(ctl: phoneController),
                const SizedBox(
                  height: 10.0,
                ),
                // GestureDetector(
                //   onTap: () => showBottomSheet(),
                //   child: getCountryForm(text: country),
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                getRegisterForm(ctl: password, icon: Icons.lock_outlined, obscure: true, hint: 'Password'),
                const SizedBox(
                  height: 10.0,
                ),
                getRegisterPasswordForm(
                  ctl: confirmPassword,
                  hint: 'Confirm Password',
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
                      }, text: 'Register'),
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
                      style: GoogleFonts.poppins(fontSize: 13.0, color: Color(0xFF838391), fontWeight: FontWeight.w400),
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
                    socialAccount(FontAwesome.facebook, Color(0xFF1777F2), callBack: () => FirebaseMethods.facebookLogin()),
                    const SizedBox(
                      width: 20.0,
                    ),
                    socialAccount(FontAwesome.linkedin, Color(0xFF0078B5), callBack: () {
                      Get.to(() => LinkedInUserWidget(
                            redirectUrl: LINKEDIN_REDIRECT,
                            clientId: LINKEDIN_CLIENTID,
                            clientSecret: LINKEDIN_SECRET,
                            projection: const [
                              ProjectionParameters.id,
                              ProjectionParameters.localizedFirstName,
                              ProjectionParameters.localizedLastName,
                              ProjectionParameters.firstName,
                              ProjectionParameters.lastName,
                              ProjectionParameters.profilePicture,
                            ],
                            onGetUserProfile: (user) {
                              print(
                                  '${user.user.token.accessToken} - ${user.user.firstName!.localized!.label} - ${user.user.lastName!.localized!.label} - ${user.user.profilePicture!.displayImageContent!.elements!.first.identifiers!.first.identifier} - ${user.user.userId} - ${user.user.email!.elements!.first.handleDeep!.emailAddress}');
                              Get.offAll(() => DashBoard());
                            },
                            onError: (e) {
                              print('Error: ${e.toString()}');
                              print('Error: ${e.stackTrace.toString()}');
                            },
                          ));
                    }),
                    const SizedBox(
                      width: 20.0,
                    ),
                    socialAccount(FontAwesome.google, Colors.redAccent, callBack: () => FirebaseMethods.googleSignIn()),
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
                        style: GoogleFonts.poppins(fontSize: 15.0, color: Colors.black45, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => AuthLogin()),
                      child: Text('Sign In', style: GoogleFonts.poppins(fontSize: 16.0, color: BLUECOLOR, fontWeight: FontWeight.normal)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 46.0,
                ),
              ]),
            )));
  }

  void validDate() async {
    if (firstname.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'First Name required'));
      return;
    }

    if (lasttname.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Last Name required'));
      return;
    }

    if (password.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'password required'));
      return;
    }

    if (confirmPassword.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'comfirm password required'));
      return;
    }

    if (confirmPassword.text.trim() != password.text.trim()) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'confirm password does not match'));
      return;
    }

    if (isEmail && email.text.trim().isEmpty) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'E-mail is required'));
      return;
    }

    if (isEmail && !email.text.trim().isEmail) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'E-mail is not valid'));
      return;
    }

    if (!isEmail && phoneController.value == null) {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Phone Nuber is required'));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final res = await http
          .post(Uri.parse('${ROOTAPI}/api/v1/register'),
              body: isEmail
                  ? {
                      'email': email.text.trim(),
                      'first_name': firstname.text.trim(),
                      'last_name': lasttname.text.trim(),
                      'password': password.text.trim(),
                      'password_confirmation': confirmPassword.text.trim(),
                      'user_type': "Patient"
                      //'country_id': '$country_id'
                    }
                  : {
                      'phone': '+${phoneController.value!.countryCode}${phoneController.value!.nsn}',
                      'first_name': firstname.text.trim(),
                      'last_name': lasttname.text.trim(),
                      'password': password.text.trim(),
                      'password_confirmation': confirmPassword.text.trim(),
                      'user_type': "Patient"
                      // 'country_id': '$country_id'
                    })
          .timeout(Duration(seconds: 15), onTimeout: () {
        setState(() => isLoading = false);
        return popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Connection Timeout..', status: false));
      });
      if (res.statusCode == 200) {
        popupMessage.dialogMessage(
            context,
            popupMessage.serviceMessage(context, 'Registration successfully.', status: true, cB: () {
              Get.to(() => AuthOtp(isEmail ? email.text.trim() : '+${phoneController.value!.countryCode}${phoneController.value!.nsn}', false));
            }),
            barrierDismiss: false);
      } else {
        final parsed = jsonDecode(res.body);
        popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, parsed['message'], status: false));
      }
    } on SocketException {
      popupMessage.dialogMessage(context, popupMessage.serviceMessage(context, 'Plase check internect connection', status: false));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              style: GoogleFonts.poppins(fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.w700),
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
                                        country_id = '${countryList[index]['id']}';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '${countryList[index]['name']}',
                                        style: getCustomFont(size: 16.0, color: Colors.black),
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
                decoration: BoxDecoration(color: isEmail ? BLUECOLOR : Colors.transparent, borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'with Email Address',
                    style: GoogleFonts.poppins(fontSize: 12.0, color: isEmail ? Colors.white : BLUECOLOR),
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
                decoration: BoxDecoration(color: !isEmail ? BLUECOLOR : Colors.transparent, borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'with Mobile Number',
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontSize: 12.0, color: !isEmail ? Colors.white : BLUECOLOR),
                  )),
                ),
              ),
            ),
          ),
        ],
      );
}
