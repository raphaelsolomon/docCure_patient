import 'package:doccure_patient/auth/onboarding.dart';
import 'package:doccure_patient/auth/otp.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/store/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../services/request.dart';

class AllHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const AllHomePage(this.scaffold, {super.key});

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
    return Container(
      width: width,
      height: height,
      color: Color(0xFFf6f6f6),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  color: BLUECOLOR,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap: () => widget.scaffold.currentState!.openDrawer(), child: Icon(Icons.menu, color: Colors.white)),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: isImage
                                  ? NetworkImage(box.get(USERPATH)!.profilePhoto!.replaceAll('http://localhost:8003', ROOTAPI))
                                  : NetworkImage('https://img.freepik.com/free-vector/flat-hand-drawn-patient-taking-medical-examination-illustration_23-2148859982.jpg?w=2000'),
                              radius: 20.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 50.0),
                        child: FittedBox(
                          child: GestureDetector(
                            onTap: () => Get.to(() => OnBoardingScreen()),
                            child: Text(
                              'Welcome, ${user!.name}',
                              style: getCustomFont(size: 26.0, color: Colors.white, weight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'What would you like to do today?',
                          style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                !user!.onboarded!
                    ? const SizedBox()
                    : Column(
                        children: [
                          GestureDetector(onTap: () => Get.to(() => AuthOtp(user!.email!, true)), child: mailAlert(context)),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [...List.generate(homeItem1.length, (i) => horizontalItem(homeItem1[i], i, 'first'))],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [...List.generate(homeItem2.length, (i) => horizontalItem(homeItem2[i], i, 'second'))],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [...List.generate(3, (index) => horizontalSecondItem(context, index))],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget horizontalItem(homeItem1, i, String type) => GestureDetector(
        onTap: () => onClickedEventForServices(i, type),
        child: Container(
          width: 160.0,
          height: 235.0,
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
              Image.asset(
                '${homeItem1['icon']}',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${homeItem1['title']}',
                textAlign: TextAlign.center,
                style: getCustomFont(size: 13.5, color: Colors.black, weight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${homeItem1['desc']}',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: getCustomFont(size: 12.0, color: Colors.black45, weight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      );

  Widget horizontalSecondItem(context, index) => Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 100.0,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/ads/black${index}.jpg'), fit: BoxFit.cover), color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      );

  Widget mailAlert(context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
        margin: const EdgeInsets.only(right: 20.0, left: 20.0),
        decoration: BoxDecoration(color: Colors.red.withOpacity(.2), borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/message.png', width: 50.0, height: 50.0, fit: BoxFit.contain),
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
                    style: getCustomFont(size: 18.0, color: Colors.black, weight: FontWeight.bold),
                  )),
                  const SizedBox(height: 1.0),
                  FittedBox(
                      child: Text(
                    'verify your email to link your account',
                    style: getCustomFont(size: 14.0, color: Colors.black54, weight: FontWeight.w400),
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

  onClickedEventForServices(int i, String type) {
    if (type == 'first') {
      switch (i) {
        case 3:
          break;

        case 1:
          context.read<HomeController>().setPage(-16);
          if (context.read<HomeController>().isEstoreClicked) {
            context.read<HomeController>().isEstore(false);
            Navigator.pop(context);
          }
          break;

        case 2:
          if (context.read<HomeController>().isEstoreClicked) {
            context.read<HomeController>().setStoreIndex(0);
            return;
          }
          context.read<HomeController>().isEstore(true);
          Get.to(() => StorePage(0));
          break;

        case 0:
          if (context.read<HomeController>().isEstoreClicked) {
            context.read<HomeController>().setStoreIndex(2);
            return;
          }
          context.read<HomeController>().isEstore(true);
          Get.to(() => StorePage(2));
          break;
      }
    }
    if (type == 'first') {
      switch (i) {
        case 0:
          break;
      }
    }
  }
}
