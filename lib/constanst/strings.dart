// ignore_for_file: constant_identifier_names

import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

const String CALL_COLLECTION = "call";
const String APP_ID = "696c822eb6044bdda1120f3a7ae97fc2";
//const String TOKEN = "006ee267e6dae9e4c66bf1946fb905646abIABNQv9e6lg/MtUKvQqYkDmT0aH4d1kc/LnMGrln4Am4xVgUM64AAAAAEACGukDPGADwYgEAAQAXAPBi";
const String CALL_STATUS_DIALLED = "dialled";
const String CALL_STATUS_RECEIVED = "received";
const String CALL_STATUS_MISSED = "missed";

List<User> users = [
  // User(
  //     email: 'phoenixk54@gmail.com',
  //     name: 'Uzoechi chigozie',
  //     uid: 'darkseidjdbjsbkjv',
  //     username: 'phoenixk54',
  //     profilePhoto:
  //         'https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg',
  //     status: 'Online',
  //     state: 1),
  User(
      email: 'phoenixk545@gmail.com',
      name: 'Uchiha Madara',
      uid: 'phoenixk5weufuhieh',
      username: 'phoenixk545',
      profilePhoto:
          'https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg',
      status: 'Online',
      state: 1),
];

const BoxName = 'userBox';

List ONBOARDING = [
  {
    'image': 'assets/imgs/1.png',
    'title': 'Instant Prescription',
    'description':
        'Get access to Doctors and Pharmacist if you are not sure of your prescription, you can easily chat and book online appointment with any Doctor of your Choice.'
  },
  {
    'image': 'assets/imgs/2.png',
    'title': 'Book Appointments with Doctors Right from your Phone and System!',
    'description':
        'Get Access to a wide range of Specialist Doctors around the World have never been this easy.'
  },
  {
    'image': 'assets/imgs/3.png',
    'title': 'Browse the Largest Database',
    'description':
        'of Doctors, Nurses, Pharmacist, Pharmacy Stores, Hospital and Clinics, Health Insurance and Other Health Services Providers in Africa and Globally with Just a click Away.'
  },
  {
    'image': 'assets/imgs/4.png',
    'title': 'Book Diagnostic Test from Experts Diagnostic Centers Globally!',
    'description':
        'You can have your Diagnostics Done on Schedule with our Wide network of Reliable Facilities and Centers.'
  },
  {
    'image': 'assets/imgs/5.png',
    'title': 'Get Your Prescriptions and Orders Delivered at Your Door Step!',
    'description':
        'You Can Order You’re Medications, Health Equipment and Accessories Delivered to Your Home or Office at your Convenience'
  }
];

final SHADOW = [
  BoxShadow(
      color: Colors.black12,
      spreadRadius: 1.0,
      blurRadius: 10.0,
      offset: Offset(0.0, 1.0))
];

const BLUECOLOR = Color(0xFF00329B);
const BODYTEXT = Color(0xFF373737);
const GREYTEXT = Color(0xFFA1A1A1);

List<String> month = [
  'January',
  'Febuary',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List Specialities = [
  {'title': 'Urology', 'asset': 'assets/imgs/special/'},
  {'title': 'Neurology', 'asset': 'assets/imgs/special/'},
  {'title': 'Cardiology', 'asset': 'assets/imgs/special/'},
  {'title': 'Dentist', 'asset': 'assets/imgs/special/'},
  {'title': 'Optician', 'asset': 'assets/imgs/special/'},
  {'title': 'Gynecology', 'asset': 'assets/imgs/special/'},
];

getCustomFont({size = 14.0, color = Colors.black54, weight = FontWeight.w400}) {
  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: weight);
}

getNavdraweritem(BuildContext context) {
  return [
    {'image': FontAwesome.home, 'title': 'Dashboard', 'index': 0},
    {'image': FontAwesome5.heart, 'title': 'My Vitals & Target', 'index': 1},
    {'image': FontAwesome5.store, 'title': 'E-store', 'index': 2},
    {'image': FontAwesome5.user_nurse, 'title': 'Doctor Booking', 'index': 3},
    {'image': FontAwesome5.calendar, 'title': 'My Appointment', 'index': 4},
    {'image': FontAwesome5.facebook_messenger, 'title': 'message', 'index': 5},
    {'image': FontAwesome5.file_invoice, 'title': 'My Invoices', 'index': 6},
  ];
}

const DUMMYTEXT = 'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled';
