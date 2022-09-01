import 'package:doccure_patient/constanst/strings.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class ProfileSettings extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const ProfileSettings(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  var selectedDate = DateTime.now();
  String index = 'Basic Info';
  String pricing = 'Free';
  List<String> headers = [
    'Basic Info',
    'About Me',
    'Clinic Info',
    'Contact Details',
    'Pricing & Services',
    'Education & Experience'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFf6f6f6),
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            width: MediaQuery.of(context).size.width,
            height: 86.0,
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
                            onTap: () =>
                                widget.scaffold.currentState!.openDrawer(),
                            child: Icon(Icons.menu, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Profile',
                            style:
                                getCustomFont(size: 18.0, color: Colors.white))
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  )
                ],
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [...headers.map((e) => _dashList(e)).toList()],
              ),
            ),
          ),
          Expanded(
              child: index == 'Basic Info'
                  ? basicInfo()
                  : index == 'About Me'
                      ? aboutMe()
                      : index == 'Clinic Info'
                          ? clinicInfo()
                          : index == 'Contact Details'
                              ? addressInfo()
                              : index == 'Pricing & Services'
                                  ? pricingServices()
                                  : educationExperience())
        ]));
  }

  Widget _dashList(e) => GestureDetector(
        onTap: () => setState(() => index = e),
        child: Container(
            margin: const EdgeInsets.only(right: 5.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: index == e ? BLUECOLOR : Colors.transparent,
                borderRadius: BorderRadius.circular(50.0)),
            child: Text(
              '$e',
              style: getCustomFont(
                  size: 14.0,
                  color: index == e ? Colors.white : Colors.black,
                  weight: FontWeight.normal),
            )),
      );

  getCardForm(label, hint, {ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: getCustomFont(
              size: 13.0, color: Colors.black54, weight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 48.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.transparent),
          child: TextField(
            style: getCustomFont(size: 14.0, color: Colors.black45),
            maxLines: 1,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                hintStyle: getCustomFont(size: 14.0, color: Colors.black45),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }

  getRichTextForm(label, hint, {ctl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: getCustomFont(
              size: 13.0, color: Colors.black54, weight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.transparent),
          child: TextField(
            style: getCustomFont(size: 14.0, color: Colors.black45),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                hintStyle: getCustomFont(size: 12.0, color: Colors.black45),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }

  getDropDownAssurance(label, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: getCustomFont(
              size: 13.0, color: Colors.black54, weight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 49.0,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8.0)),
          child: FormBuilderDropdown(
            name: 'gender',
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 9.9, vertical: 5.0),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none),
            ),
            initialValue: 'Male',
            items: ['Male', 'Female']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(
                        gender,
                        style: getCustomFont(size: 13.0, color: Colors.black45),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Next',
              style: getCustomFont(
                  size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );

  Widget getDateForm(label, text, callBack) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: getCustomFont(
                size: 13.0, color: Colors.black54, weight: FontWeight.normal),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            height: 48.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade200),
                color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('$text',
                      style: getCustomFont(size: 13.0, color: Colors.black45)),
                )),
                GestureDetector(
                  onTap: () => callBack(),
                  child: PhysicalModel(
                    elevation: 10.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 9.0),
                      child: Icon(
                        Icons.calendar_month,
                        size: 17.0,
                        color: Color(0xFF838383),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );

  //====================page 1=============================
  Widget basicInfo() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Basic Information',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/imgs/1.png'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            getCardForm('Username', 'JohnDoe98'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Full Name', 'John'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Last Name', 'Doe'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('phone Number', ''),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('E-mail Address', 'Johndoe55@gmail.com'),
            const SizedBox(
              height: 15.0,
            ),
            getDropDownAssurance('Gender', context),
            const SizedBox(
              height: 15.0,
            ),
            getDateForm('Date of Birth',
                DateFormat('dd EEEE, MMM, yyyy').format(selectedDate), () {}),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  Widget aboutMe() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'About Me',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 20.0,
            ),
            getRichTextForm(
              'Biography',
              'Within 400 character',
            ),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  Widget clinicInfo() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Clinic Information',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 20.0,
            ),
            getCardForm('Clinic Name', ''),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Clinic Address', ''),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Clinic images',
              style: getCustomFont(
                  size: 13.0, color: Colors.black54, weight: FontWeight.normal),
            ),
            const SizedBox(
              height: 5.0,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(8.0),
              dashPattern: [8, 4],
              strokeCap: StrokeCap.butt,
              color: Colors.black45,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade200),
                child: Center(
                  child: Text('Click her to upload images',
                      style: getCustomFont(
                        size: 13.0,
                        color: Colors.black45,
                        weight: FontWeight.normal,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  Widget addressInfo() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Contact Details',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 30.0,
            ),
            getCardForm('Address 1', 'JohnDoe98'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Address 2', 'John'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('City', 'Doe'),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('State / Province', ''),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Country', 'Postal Code'),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  Widget pricingServices() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Pricing',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Flexible(
                    child: Row(
                  children: [
                    Radio(
                        value: pricing == 'Free',
                        groupValue: true,
                        onChanged: (b) {
                          setState(() {
                            pricing = 'Free';
                          });
                        }),
                    Text(
                      'Free',
                      style: getCustomFont(size: 12.0, color: Colors.black45),
                    )
                  ],
                )),
                Flexible(
                    child: Row(
                  children: [
                    Radio(
                        value: pricing == 'Custom Price (per hour)',
                        groupValue: true,
                        onChanged: (b) {
                          setState(() {
                            pricing = 'Custom Price (per hour)';
                          });
                        }),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          'Custom Price (per hour)',
                          style:
                              getCustomFont(size: 13.0, color: Colors.black45),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
            getCardForm('', ''),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Services', ''),
            const SizedBox(
              height: 15.0,
            ),
            getCardForm('Specialization', ''),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  Widget educationExperience() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Education',
                  style: getCustomFont(size: 17.0, color: Colors.black),
                )),
            const SizedBox(
              height: 10.0,
            ),
            ListView.builder(
                padding: const EdgeInsets.all(0.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) => getEducationItem()),
            const SizedBox(
              height: 30.0,
            ),
            getButton(context, () {}),
            const SizedBox(
              height: 10.0,
            ),
          ]),
        ),
      );

  //====================EducationItem======================
Widget getEducationItem() => Column(
  children: [
    getCardForm('Degree', ''),
    const SizedBox(
      height: 15.0,
    ),
    getCardForm('Year of Completion', ''),
    const SizedBox(
      height: 15.0,
    ),
    getCardForm('College/Institute', ''),
  ],
);
}
