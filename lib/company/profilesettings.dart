import 'dart:io';

import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ProfileSettings(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  ImagePicker _picker = ImagePicker();
  File image = File('');

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
           Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            width: MediaQuery.of(context).size.width,
            color: BLUECOLOR,
            child: Column(children: [
              const SizedBox(
                height: 45.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => context.read<HomeController>().onBackPress(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18.0,
                      )),
                  Text('Profile Settings',
                      style: getCustomFont(color: Colors.white, size: 16.0)),
                  Icon(
                    null,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
            ]),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Information',
                          style: getCustomFont(size: 16.0, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                var img = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  image = File(img!.path);
                                });
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: image.path == ''
                                      ? Image.asset(
                                          'assets/imgs/1.png',
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.file(
                                          image,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.contain,
                                        )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        getFormBox('First Name', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Last Name', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Date of Birth', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        dropDown(text: 'Blood Group'),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Email ID', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Mobile', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Address', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('City', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('State', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Zip Code', ''),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Country', ''),
                        const SizedBox(
                          height: 20.0,
                        ),
                        getButton(context, () {}, 'Done'),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ]));
  }

  getFormBox(text, hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text',
            style: getCustomFont(size: 12.0, color: Colors.black),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Container(
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 0.6, color: Colors.black45),
              color: Colors.grey.shade100,
            ),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    style: getCustomFont(size: 14.0, color: Colors.black45),
                    maxLines: 1,
                    controller: ctl,
                    decoration: InputDecoration(
                        hintText: hint,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle:
                            getCustomFont(size: 14.0, color: Colors.black45),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(0.0))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
              height: 4.0,
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: const EdgeInsets.only(top: 5.0),
                    child: FormBuilderDropdown(
                      name: 'skill',
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 9.9, vertical: 5.0),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 0.6, color: Colors.grey),
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
              ],
            ),
          ],
        ),
      );
}
