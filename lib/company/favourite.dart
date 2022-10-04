import 'dart:convert';

import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/favourite_model.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class MyFavourite extends StatefulWidget {
  const MyFavourite({Key? key}) : super(key: key);

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  bool isLoading = true;
  FavouriteModel? favouriteModel;
  final box = Hive.box<User>(BoxName);
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getFavourites(_refreshController).then((value) => setState(() {
            favouriteModel = value;
            isLoading = false;
          }));
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
                  Text('Favorites',
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
            height: 5.0,
          ),
          Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SmartRefresher(
                      enablePullDown: true,
                      header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                      controller: _refreshController,
                      onRefresh: () => getFavourites(_refreshController)
                          .then((value) => setState(() {
                                favouriteModel = value;
                              })),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          itemCount: favouriteModel!.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) => findDoctors(context, favouriteModel!.data![i])),
                    ))
        ]));
  }

  Widget findDoctors(context, Data data) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 1.0))
        ], color: Colors.white, borderRadius: BorderRadius.circular(13.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      'assets/imgs/2.png',
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 13.0,
                ),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${data.name}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'MDS - periodontology, BDS',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              PhysicalModel(
                                elevation: 10.0,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                                shadowColor: Colors.grey,
                                child: SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: Icon(
                                    FontAwesome5.teeth,
                                    size: 11.0,
                                    color: Color(0xFF838383),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${data.specialization}',
                                style: GoogleFonts.poppins(
                                    color: Colors.lightBlue,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '9+ Exp',
                          style: GoogleFonts.poppins(
                              color: Colors.redAccent,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15.0,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '(47)',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 14.0,
                            ),
                            Text(
                              '${data.state}, ${data.country ?? ''}',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Divider(),
            const SizedBox(
              height: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      PhysicalModel(
                        elevation: 10.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0),
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Icon(
                            Icons.thumb_up,
                            size: 12.0,
                            color: Color(0xFF838383),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        '98%',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    PhysicalModel(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: Icon(
                          Icons.money,
                          size: 12.0,
                          color: Color(0xFF838383),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      '\$${data.consultationFee}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Flexible(
                  child: getProfileButton(context, () {
                    context.read<HomeController>().setPage(-4);
                  }),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: getAppointment(context, () {
                    context.read<HomeController>().setPage(-1);
                  }, text: 'Book Appointment'),
                )
              ],
            )
          ],
        ),
      );

  Widget getProfileButton(context, callBack, {text = 'View Profile'}) =>
      GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0, color: BLUECOLOR),
              borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    color: BLUECOLOR,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );

  Widget getAppointment(context, callBack, {color = BLUECOLOR, text = 'Search Now'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      );

  Future<FavouriteModel> getFavourites(RefreshController controller) async {
    FavouriteModel model = new FavouriteModel();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/favorites/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return model = FavouriteModel.fromJson(jsonDecode(value));;
      });
    }
    controller.refreshFailed();
    return model;
  }
}
