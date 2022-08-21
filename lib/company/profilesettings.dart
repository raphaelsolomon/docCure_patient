import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ProfileSettings(this.scaffold, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 90.0,
            color: BLUECOLOR,
            child: Column(children: [
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () => scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu,
                                size: 20.0, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Profile Settings',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<HomeController>().setPage(12);
                    },
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                'assets/imgs/1.png',
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.contain,
                              ),
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
              border: Border.all(width: 1.0, color: Colors.black54),
              color: Colors.white,
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 9.9, vertical: 5.0),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.grey),
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
