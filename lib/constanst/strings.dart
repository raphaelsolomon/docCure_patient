// ignore_for_file: constant_identifier_names

import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';

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
    'description': 'Get access to Doctors and Pharmacist if you are not sure of your prescription, you can easily chat and book online appointment with any Doctor of your Choice.'
  },
  {
    'image': 'assets/imgs/2.png',
    'title': 'Book Appointments with Doctors Right from your Phone and System!',
    'description': 'Get Access to a wide range of Specialist Doctors around the World have never been this easy.'
  },
  {
    'image': 'assets/imgs/3.png',
    'title': 'Browse the Largest Database',
    'description': 'of Doctors, Nurses, Pharmacist, Pharmacy Stores, Hospital and Clinics, Health Insurance and Other Health Services Providers in Africa and Globally with Just a click Away.'
  },
  {
    'image': 'assets/imgs/4.png',
    'title': 'Book Diagnostic Test from Experts Diagnostic Centers Globally!',
    'description': 'You can have your Diagnostics Done on Schedule with our Wide network of Reliable Facilities and Centers.'
  },
  {
    'image': 'assets/imgs/5.png',
    'title': 'Get Your Prescriptions and Orders Delivered at Your Door Step!',
    'description': 'You Can Order You’re Medications, Health Equipment and Accessories Delivered to Your Home or Office at your Convenience'
  }
];


const BLUECOLOR = Color(0xFF00329B);
const BODYTEXT = Color(0xFF373737);
const GREYTEXT = Color(0xFFA1A1A1);