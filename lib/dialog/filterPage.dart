import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var selectedDate = DateTime.now();
  String gender = 'male';
  List<String> specialist = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Divider(),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0), color: BLUECOLOR),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Filter',
                      style: getCustomFont(size: 18.0, color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Text(
                        'Clear',
                        style: getCustomFont(size: 13.0, color: Colors.white),
                      ),
                    ),
                  )
                ]),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Date',
                style: getCustomFont(
                    size: 15.0, color: Colors.black, weight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            getDateForm(DateFormat('yyyy-MM-dd').format(selectedDate), () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101));
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            }),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Gender',
                style: getCustomFont(
                    size: 15.0, color: Colors.black, weight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Flexible(
                  child: getGenderForm('assets/imgs/male.png', 'Male'),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: getGenderForm('assets/imgs/female.png', 'Female'),
                )
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Select Specialist',
                style: getCustomFont(
                    size: 15.0, color: Colors.black, weight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Flexible(child: getSpecialistForm('Urologist')),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(child: getSpecialistForm('Cardiologist')),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Flexible(child: getSpecialistForm('Dentist')),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(child: getSpecialistForm('Neurologist')),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Flexible(child: getSpecialistForm('Orthologist')),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(child: getSpecialistForm('Gynecologist')),
              ],
            ),
             const SizedBox(
              height: 30.0,
            ),
            getButton(context, (){}),
             const SizedBox(
              height: 20.0,
            ),
            ],),
          ))
        ],
      ),
    );
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          decoration: BoxDecoration(
              color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              'Apply Filter',
              style: getCustomFont(
                  size: 14.0, color: Colors.white, weight: FontWeight.normal),
            ),
          ),
        ),
      );

  getDateForm(text, callBack) => Container(
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
                      horizontal: 10.0, vertical: 10.0),
                  child: Icon(
                    Icons.calendar_month,
                    size: 18.0,
                    color: Color(0xFF838383),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  getGenderForm(asset, text) => Container(
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
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Image.asset(
                    '$asset',
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text('$text',
                      style: getCustomFont(size: 13.0, color: Colors.black45)),
                ],
              ),
            )),
            Radio(
                value: gender == '$text'.toLowerCase(),
                groupValue: true,
                onChanged: (b) =>
                    setState(() => gender = '$text'.toLowerCase()))
          ],
        ),
      );

  getSpecialistForm(text) => Container(
        height: 54.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Radio(
                value: specialist.contains('$text'.toLowerCase()),
                groupValue: true,
                onChanged: (b) {
                  int i = specialist.indexWhere((element) =>
                      element.toLowerCase() == '$text'.toLowerCase());
                  if (i < 0) {
                    specialist.add('$text'.toLowerCase());
                  } else {
                    specialist.removeAt(i);
                  }
                  setState(() {});
                }),
           
            Flexible(
                child: Text('$text',
                    style: getCustomFont(size: 13.0, color: Colors.black45))),
          ],
        ),
      );
}
