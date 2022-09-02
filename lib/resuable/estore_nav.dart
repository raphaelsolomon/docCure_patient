import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class StoreNav extends StatelessWidget {
  final BuildContext c;
  const StoreNav(this.c, {Key? key}) : super(key: key);

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
            getNavItems(FontAwesome5.pills, 'Medicine', () {
              readExec.setPage(0);
            }, counter.last == 0),
            getNavItems(FontAwesome5.user_nurse, 'Doctors', () {
              readExec.setPage(0);
            }, counter.last == 4),
            getNavItems(Icons.add_location_alt, 'Hospitals', () {
              readExec.setPage(0);
            }, counter.last == 1),
            getNavItems(Icons.calendar_month_rounded, 'Appts', () {
              readExec.setPage(0);
            }, counter.last == 3),
            getNavItems(Icons.person_outline, 'More', () {
              readExec.setPage(0);
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
