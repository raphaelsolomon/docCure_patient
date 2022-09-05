import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/store/index.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  final BuildContext c;
  final int pageIndex = 0;
  const CustomNavBar(this.c, {pageIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = context.watch<HomeController>().index;
    var readExec = context.watch<HomeController>();
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getNavItems(Icons.house_outlined, 'Home', () {
              readExec.jumpToHome();
              if(readExec.isEstoreClicked){
                readExec.isEstore(false);
                Navigator.pop(context);
              }
            }, counter.last == 0),
            getNavItems(FontAwesome5.user_nurse, 'Doctors', () {
              readExec.setPage(3);
               if(readExec.isEstoreClicked){
                readExec.isEstore(false);
                Navigator.pop(context);
              }
            }, counter.last == 3),
            getNavItems(Icons.store, 'E-Stores', () {
               if(readExec.isEstoreClicked) {
                return;
              }
              Get.to(() => StorePage(0));
            }, readExec.isEstoreClicked && pageIndex == 0),
            getNavItems(Icons.receipt_long_outlined, 'Hospitals', () {
              Get.to(() => StorePage(2));
            }, readExec.isEstoreClicked && pageIndex == 2),
            getNavItems(Icons.more, 'More', () {
              
            }, counter.last == 2),
          ],
        ),
      ),
    );
  }

  getNavItems(icon, text, cB, b) {
    return InkWell(
      onTap: () => cB(),
      child: Column(
        children: [
          FaIcon(
            icon,
            size: 21.0,
            color: b? BLUECOLOR : Colors.black,
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            '$text',
            style:
                getCustomFont(size: 10.0, color: b ? BLUECOLOR : Colors.black),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Icon(
            Icons.circle,
            size: 8.0,
            color: b ? BLUECOLOR : Colors.transparent,
          )
        ],
      ),
    );
  }
}
