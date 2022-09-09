import 'package:doccure_patient/auth/otp.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AllHomePage extends StatefulWidget {
  const AllHomePage({super.key});

  @override
  State<AllHomePage> createState() => _AllHomePageState();
}

class _AllHomePageState extends State<AllHomePage> {
  final box = Hive.box<User>(BoxName);
  User? user;
  bool isImage = true;

  @override
  void initState() {
    user = box.get(USERPATH);
    isImage = user!.profilePhoto == null ? false : true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: width,
        height: height,
        color: Color(0xFFf6f6f6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CircleAvatar(
                  backgroundImage: isImage
                      ? NetworkImage(user!.profilePhoto!)
                      : NetworkImage(
                          'https://img.freepik.com/free-vector/flat-hand-drawn-patient-taking-medical-examination-illustration_23-2148859982.jpg?w=2000'),
                  radius: 20.0,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 50.0),
                child: FittedBox(
                  child: Text(
                    user!.gender == null
                        ? 'Welcome, ${user!.name}'
                        : user!.gender!.toLowerCase() == 'male'
                            ? 'Welcome, Mr. ${user!.name}'
                            : 'Welcome, Mrs. ${user!.name}',
                    style: getCustomFont(
                        size: 26.0,
                        color: Colors.black,
                        weight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 3.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'What would you like to do today?',
                  style: getCustomFont(
                      size: 13.0, color: Colors.black, weight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              user!.verified!
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () => Get.to(() => AuthOtp(user!.email!)),
                      child: mailAlert(context)),
              const SizedBox(
                height: 29.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      ...List.generate(10, (index) => horizontalItem())
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      ...List.generate(10, (index) => horizontalItem())
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      ...List.generate(
                          4, (index) => horizontalSecondItem(context))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalItem() => Container(
        width: 185.0,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Image.asset(
              'assets/imgs/1.png',
              width: 80.0,
              height: 80.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Find a medical center',
              textAlign: TextAlign.center,
              style: getCustomFont(
                  size: 15.0, color: Colors.black, weight: FontWeight.w600),
            ),
            const SizedBox(
              height: 9.0,
            ),
            Text(
              'Find hosiptals, pharmacies, laboratories and clinics',
              textAlign: TextAlign.center,
              style: getCustomFont(
                  size: 12.0, color: Colors.black45, weight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5.0,
            ),
          ],
        ),
      );

  Widget horizontalSecondItem(context) => Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 100.0,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: BLUECOLOR.withOpacity(.5),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [],
        ),
      );

  Widget mailAlert(context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
        margin: const EdgeInsets.only(right: 20.0, left: 20.0),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(.2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/message.png',
                width: 50.0, height: 50.0, fit: BoxFit.contain),
            const SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      child: Text(
                    'E-mail Verification Pending',
                    style: getCustomFont(
                        size: 18.0,
                        color: Colors.black,
                        weight: FontWeight.bold),
                  )),
                  const SizedBox(height: 1.0),
                  FittedBox(
                      child: Text(
                    'verify your email to link your account',
                    style: getCustomFont(
                        size: 14.0,
                        color: Colors.black54,
                        weight: FontWeight.w400),
                  )),
                ],
              ),
            ),
            const SizedBox(
              width: 30.0,
            ),
            Icon(
              Icons.warning,
              color: Colors.red,
              size: 19.0,
            )
          ],
        ),
      );
}
