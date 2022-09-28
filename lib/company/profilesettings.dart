import 'dart:convert';
import 'dart:io';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:doccure_patient/dialog/subscribe.dart' as popupMessage;

class ProfileSettings extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ProfileSettings(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  ImagePicker _picker = ImagePicker();
  File image = File('');
  var country_id = '';
  var bloodGroup = '';
  PhoneController phoneController = PhoneController(null);

  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zip_code = TextEditingController();
  final email = TextEditingController();
  final country = TextEditingController();

  bool isloading = false;
  var _selectedDate = DateTime.now();
  final box = Hive.box<User>(BoxName);

  final fullname = TextEditingController();
  var dateOfBirth = '';

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fullname.text = box.get(USERPATH)!.name!;
      email.text =
          box.get(USERPATH)!.email == null ? '' : box.get(USERPATH)!.email!;
      address.text =
          box.get(USERPATH)!.address == null ? '' : box.get(USERPATH)!.address!;
      city.text =
          box.get(USERPATH)!.city == null ? '' : box.get(USERPATH)!.city!;
      state.text =
          box.get(USERPATH)!.state == null ? '' : box.get(USERPATH)!.state!;
      zip_code.text = box.get(USERPATH)!.zip_code == null
          ? ''
          : box.get(USERPATH)!.zip_code!;

      var i = countryList.indexWhere((element) => '${element['id']}' == '${box.get(USERPATH)!.country}');
      country.text = countryList.elementAt(i)['name'];
      country_id = '${countryList.elementAt(i)['id']}';

      bloodGroup = box.get(USERPATH)!.bloodgroup == null
          ? 'Blood Group'
          : box.get(USERPATH)!.bloodgroup!;

      _selectedDate = box.get(USERPATH)!.dob == null
          ? DateTime.now()
          : DateTime.parse(box.get(USERPATH)!.dob!);
    });
    super.initState();
  }

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
                        vertical: 15.0, horizontal: 5.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0),
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
                        getFormBox('Full Name', '', ctl: fullname),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                            child: getFormBox('Date of Birth',
                                '${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                            onTap: () async {
                                showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now())
                                  .then((pickedDate) {
                                if (pickedDate == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              });
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        dropDown(
                          ['AA', 'AB', 'O+', 'O-'],
                          text: 'Blood Group',
                          label: bloodGroup, callBack: (s) => bloodGroup = s,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Email ID', '', ctl: email),
                        const SizedBox(
                          height: 10.0,
                        ),
                        phoneNumber('Mobile', '', ctl: phoneController),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Address', '', ctl: address),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('City', '', ctl: city),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('State', '', ctl: state),
                        const SizedBox(
                          height: 10.0,
                        ),
                        getFormBox('Zip Code', '', ctl: zip_code),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () => showBottomSheet(),
                          child: getFormBox('Country', '', ctl: country),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        isloading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: CircularProgressIndicator()))
                            : getButton(context, () => onExecute(), 'Done'),
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

  void onExecute() async {
    setState(() {
      isloading = true;
    });

    try{
     var request = http.Request('PATCH', Uri.parse('https://patientapi.gettheskydoctors.com/api/v1/auth/patient/update-profile'));
      request.body = json.encode({
      "email": email.text.trim(),
      "name": fullname.text.trim(),
      "phone": '+${phoneController.value!.countryCode}${phoneController.value!.nsn}' == null? '': '+${phoneController.value!.countryCode}${phoneController.value!.nsn}',
      "dob": DateFormat('yyyy-MM-dd').format(_selectedDate),
      "blood_group": bloodGroup,
      "address": address.text,
      "city": city.text,
      "state": state.text,
      "country": country_id,
      "zip_code": zip_code.text,
      "profile_picture": "https://www.whatspaper.com/wp-content/uploads/2021/12/hd-itachi-uchiha-wallpaper-whatspaper-21.jpg"
    });
      request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}', 'Content-Type': 'application/json'});

http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      response.stream.bytesToString().then((value)  {
        setState(() {
        isloading = true;
      });
        final parsed = jsonDecode(value);
         popupMessage.dialogMessage(context,  popupMessage.serviceMessage(context, parsed['message'], status: true));
      });
    } else {
      setState(() {
        isloading = true;
      });
      popupMessage.dialogMessage(context,  popupMessage.serviceMessage(context, response.reasonPhrase, status: false));
    }
    }on SocketException {
      setState(() {
        isloading = true;
      });
      popupMessage.dialogMessage(context,  popupMessage.serviceMessage(context, 'Check Internet Connection', status: false));
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
              style: GoogleFonts.poppins(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
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
                                        country.text = '${countryList[index]['name']}';
                                        country_id = '${countryList[index]['id']}';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '${countryList[index]['name']}',
                                        style: getCustomFont(
                                            size: 16.0, color: Colors.black),
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
              color: Colors.transparent,
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
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
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

  Widget dropDown(List<String> list, {text, label, callBack}) => Padding(
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
                      color: Colors.transparent,
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
                      onChanged: (s) => callBack(s),
                      items: list
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

  Widget phoneNumber(text, label, {ctl}) => Padding(
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
                        hintStyle:
                            getCustomFont(size: 15.0, color: Colors.black45),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.6,
                                color: Colors
                                    .black45)) // default to UnderlineInputBorder(),
                        ),
                    validator: null,
                    isCountryChipPersistent: false, // default
                    isCountrySelectionEnabled: true, // default
                    countrySelectorNavigator: CountrySelectorNavigator.dialog(),
                    showFlagInInput: true, // default
                    flagSize: 15, // default
                    autofillHints: [
                      AutofillHints.telephoneNumber
                    ], // default to null
                    enabled: true, // default
                  ),
                )),
              ],
            ),
          ],
        ),
      );
}
