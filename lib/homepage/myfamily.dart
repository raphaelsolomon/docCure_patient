import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/dialog/update_family.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class MyFamily extends StatefulWidget {
  const MyFamily({Key? key}) : super(key: key);

  @override
  State<MyFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  var family = [];
  final box = Hive.box<User>(BoxName);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFf6f6f6),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
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
                      Text('Family', style: getCustomFont(color: Colors.white, size: 16.0)),
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
              FutureBuilder<Map<String, dynamic>>(
                  future: ApiServices.getAllDepends(context, box.get(USERPATH)!.token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: Center(
                        child: CircularProgressIndicator(color: BLUECOLOR),
                      ));
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data != null) {
                        if (snapshot.data!['data'].length <= 0) {
                          return Expanded(child: emptyContainer(context));
                        }
                        return Expanded(
                          child: Stack(
                            children: [
                              Container(
                                  child: ListView.builder(itemCount: snapshot.data!['data'].length, padding: const EdgeInsets.all(0.0), itemBuilder: (ctx, i) => listItem(snapshot.data!['data'][i])),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                    child: FloatingActionButton(
                                        onPressed: () => dialogMessage(context, familyPop(context)),
                                        backgroundColor: BLUECOLOR,
                                        child: Icon(
                                          Icons.add,
                                        )),
                                  ))
                            ],
                          ),
                        );
                      } else {
                        return Expanded(child: emptyContainer(context));
                      }
                    }
                    return Text('${snapshot.error}', style: getCustomFont(size: 14.0, color: Colors.black45));
                  })
            ])),
        Visibility(
          visible: family.isNotEmpty,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: BLUECOLOR,
                radius: 30.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  listItem(e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white, boxShadow: SHADOW),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), border: Border.all(width: 2.0, color: BLUECOLOR.withOpacity(.4))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      '${e['picture'] == null ? 'https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png' : e['picture']}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e['name']}'.capitalizeFirst!,
                      style: getCustomFont(size: 14.0, color: Colors.black, weight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.family_restroom,
                          color: BLUECOLOR,
                          size: 10.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '${e['gender'].toString().capitalizeFirst}, ${e['relationship'].toString().capitalizeFirst}',
                          style: getCustomFont(size: 12.0, color: Colors.black45, weight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => showRequestSheet(context, UpdateFamily(e)),
                child: Icon(
                  Icons.edit,
                  color: BLUECOLOR,
                  size: 18.0,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: () => ApiServices.deleteDependent(context, box.get(USERPATH)!.token, e['id'], () {
                  setState(() {});
                }),
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 18.0,
                ),
              ),
            ],
          )
        ]),
      );

  emptyContainer(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_home_sharp,
              size: 79.0,
              color: BLUECOLOR,
            ),
            Text(
              'You have not created a family',
              style: getCustomFont(size: 14.0, color: Colors.black54),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Family member can pay for services and medications from one linked wallet.',
              textAlign: TextAlign.center,
              style: getCustomFont(color: Colors.black45, size: 12.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                dialogMessage(context, familyPop(context));
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: BLUECOLOR),
                padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 11.0),
                child: Text(
                  'Create a family',
                  style: getCustomFont(size: 12.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
}
