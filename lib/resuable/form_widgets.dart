import 'package:doccure_patient/auth/login.dart';
import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';

getRegisterForm(
        {ctl,
        obscure = false,
        hint,
        icon = Icons.email_outlined,
        cp,
        height = 54.0}) =>
    Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
            controller: ctl,
            obscureText: obscure,
            keyboardType: TextInputType.text,
            style: getCustomFont(size: 15.0, color: Colors.black45),
            decoration: InputDecoration(
                hintText: obscure
                    ? cp != null
                        ? 'Confirm Password'
                        : 'password'
                    : hint == null
                        ? 'johndoe@example.com'
                        : hint,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                hintStyle: getCustomFont(size: 15.0, color: Colors.black45),
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          )),
          PhysicalModel(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            shadowColor: Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(
                icon,
                size: 18.0,
                color: Color(0xFF838383),
              ),
            ),
          )
        ],
      ),
    );

getRegisterPasswordForm({ctl, hint}) => Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
            controller: ctl,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: getCustomFont(size: 15.0, color: Colors.black45),
            decoration: InputDecoration(
                hintText: hint,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                hintStyle: getCustomFont(size: 15.0, color: Colors.black45),
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          )),
          PhysicalModel(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            shadowColor: Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(
                Icons.lock_outlined,
                size: 18.0,
                color: Color(0xFF838383),
              ),
            ),
          )
        ],
      ),
    );

getCountryForm({ctl, text = 'Nigeria'}) => Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Text(
              '$text',
              style: getCustomFont(size: 15.0, color: Colors.black45),
            ),
          )),
          PhysicalModel(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            shadowColor: Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(
                FontAwesome5.globe,
                size: 18.0,
                color: Color(0xFF838383),
              ),
            ),
          )
        ],
      ),
    );

getPhoneNumberForm({ctl}) => Container(
      height: 54.0,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: PhoneFormField(
              key: Key('phone-field'),
              controller: ctl, // controller & initialValue value
              shouldFormat: true, // default
              defaultCountry: IsoCode.NG, // default
              style: getCustomFont(size: 14.0, color: Colors.black45),
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  hintText: 'Mobile Number', // default to null
                  hintStyle: getCustomFont(size: 15.0, color: Colors.black45),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide.none) // default to UnderlineInputBorder(),
                  ),
              validator: null,
              isCountryChipPersistent: false, // default
              isCountrySelectionEnabled: true, // default
              countrySelectorNavigator: CountrySelectorNavigator.dialog(),
              showFlagInInput: true, // default
              flagSize: 15, // default
              autofillHints: [AutofillHints.telephoneNumber], // default to null
              enabled: true, // default
            ),
          )),
          PhysicalModel(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            shadowColor: Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(
                Icons.smartphone,
                size: 18.0,
                color: Color(0xFF838383),
              ),
            ),
          )
        ],
      ),
    );

Widget socialAccount(icon, color, {callBack}) => GestureDetector(
      onTap: () => callBack(),
      child: Container(
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0), color: color),
      ),
    );

getButton(context, callBack,
        {text = 'Sign In', color = BLUECOLOR, textcolor = Colors.white}) =>
    GestureDetector(
      onTap: () => callBack(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 17.0,
                  color: textcolor,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );

getOtpForm({ctl, node}) => Container(
      width: 55.0,
      height: 45.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: TextFormField(
        controller: ctl,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0))),
      ),
    );

navDrawer(BuildContext context, scaffold) => Container(
      width: (MediaQuery.of(context).size.width / 2) + 78.0,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              color: BLUECOLOR,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                        onTap: () => scaffold.currentState!.closeDrawer(),
                        child: Icon(Icons.keyboard_backspace,
                            color: Colors.white)),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<HomeController>().setPage(-2);
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/imgs/2.png'),
                            radius: 30.0,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                            child: Text(
                          'John Deo',
                          style: GoogleFonts.poppins(
                              fontSize: 15.0, color: Colors.white),
                        ))
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 5.0,
            ),
            ...getNavdraweritem_(context).map((e) {
              if (e.children.isEmpty) {
                return InkWell(
                  onTap: () {
                    scaffold.currentState!.closeDrawer();
                    setClickListener(e, context);
                  },
                  child: Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 18.0,
                        child: Icon(
                          e.icon,
                          color: Colors.white,
                          size: 15.0,
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                          child: Text(
                        e.title,
                        style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87.withOpacity(.7)),
                      ))
                    ]),
                  ),
                );
              }
              return ExpansionTile(
                  tilePadding: const EdgeInsets.only(bottom: 0.0, left: 15.0, right: 15.0, top: 0.0),
                  leading: CircleAvatar(
                    radius: 18.0,
                    child: Icon(
                      e.icon,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                  title: Text(
                    e.title,
                    style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87.withOpacity(.7)),
                  ),
                  children: e.children.map((entries) {
                    return GestureDetector(
                      onTap: () => setChildrenClickListener(entries, context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 11.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(entries['title'],
                              style: getCustomFont(
                                  size: 16.0,
                                  color: Colors.black87.withOpacity(.7))),
                        ),
                      ),
                    );
                  }).toList());
            })
          ],
        ),
      ),
    );

setChildrenClickListener(e, BuildContext context) {
  switch (e['index']) {
    case 6:
      context.read<HomeController>().setPage(6);
      break;
    case 8:
      context.read<HomeController>().setPage(8);
      break;
    case 9:
      context.read<HomeController>().setPage(9);
      break;
    case -5:
      context.read<HomeController>().setPage(-5);
      break;
    case -6:
      context.read<HomeController>().setPage(-6);
      break;
    case -7:
      context.read<HomeController>().setPage(-7);
      break;
    case -8:
      context.read<HomeController>().setPage(-8);
      break;
    case -9:
      context.read<HomeController>().setPage(-9);
      break;
    case -12:
      context.read<HomeController>().setPage(-12);
      break;
    case -13:
      dialogMessage(context, language(context));
      break;
  }
}

setClickListener(e, BuildContext context) {
  switch (e.index) {
    case 0:
      context.read<HomeController>().jumpToHome();
      break;
    case 1:
      context.read<HomeController>().setPage(1);
      break;
    case 2:
      context.read<HomeController>().setPage(2);
      break;
    case 3:
      context.read<HomeController>().setPage(-3);
      break;
    case 4:
      Get.to(() => StorePage());
      break;
    case 5:
      context.read<HomeController>().setPage(5);
      break;
    case 7:
      context.read<HomeController>().setPage(7);
      break;
    case 8:
      context.read<HomeController>().setPage(8);
      break;
    case 10:
      context.read<HomeController>().setPage(10);
      break;
    case -10:
      context.read<HomeController>().setPage(-10);
      break;
    case -11:
      context.read<HomeController>().setPage(-11);
      break;
    case -2:
      context.read<HomeController>().setPage(-2);
      break;
    case 11:
      Get.offAll(() => AuthLogin());
      break;
    default:
      context.read<HomeController>().jumpToHome();
      break;
  }
}

Widget dropDown({list, text, label}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: getCustomFont(size: 12.0, color: Colors.black),
          ),
          const SizedBox(
            height: 7.0,
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  height: 45.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  margin: const EdgeInsets.only(top: 5.0),
                  child: FormBuilderDropdown(
                    name: 'skill',
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      label: Text(
                        '$label',
                        style: getCustomFont(size: 12.0, color: Colors.black),
                      ),
                      labelStyle:
                          getCustomFont(size: 12.0, color: Colors.black),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 9.9, vertical: 5.0),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    // initialValue: 'Male',
                    items: ['boy', 'girl', 'man', 'woman']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(
                                gender,
                                style: getCustomFont(
                                    size: 13.0, color: Colors.black),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
