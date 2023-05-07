import 'dart:convert';

import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/model/coupon_model.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class MyOffer extends StatefulWidget {
  const MyOffer({Key? key}) : super(key: key);

  @override
  State<MyOffer> createState() => _MyOfferState();
}

class _MyOfferState extends State<MyOffer> {
  bool isLoading = true;
  CouponModel? couponModel;
  final box = Hive.box<User>(BoxName);
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getCoupons(_refreshController).then((value) => setState(() {
            isLoading = false;
            this.couponModel = value;
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
                  Text('Offers/Coupons', style: getCustomFont(color: Colors.white, size: 16.0)),
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
            height: 15.0,
          ),
          Expanded(
              child: !isLoading
                  ? Center(child: CircularProgressIndicator(color: BLUECOLOR))
                  : SmartRefresher(
                      enablePullDown: true,
                      header: WaterDropHeader(waterDropColor: BLUECOLOR.withOpacity(.5)),
                      controller: _refreshController,
                      onRefresh: () => getCoupons(_refreshController).then((value) => setState(() {
                            this.couponModel = value;
                          })),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(0.0), itemCount: couponModel == null ? 3 : couponModel!.data!.length, shrinkWrap: true, itemBuilder: (ctx, i) => myOffers(context, couponModel == null ? [] : couponModel!.data!, i)),
                    ))
        ]));
  }

  Widget myOffers(context, List<CouponData> data, int i) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1.0, blurRadius: 10.0, offset: Offset(0.0, 1.0))], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text('')),
            const SizedBox(
              width: 20.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              decoration: BoxDecoration(color: Colors.green.withOpacity(.1)),
              child: Text(
                'Get',
                style: getCustomFont(size: 20.0, color: Colors.greenAccent, weight: FontWeight.bold),
              ),
            )
          ],
        ),
      );

  Future<CouponModel> getCoupons(RefreshController controller) async {
    CouponModel model = new CouponModel();
    var request = http.Request('GET', Uri.parse('${ROOTAPI}/api/v1/auth/patient/coupons/all'));
    request.headers.addAll({'Authorization': '${box.get(USERPATH)!.token}'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      controller.refreshCompleted();
      return response.stream.bytesToString().then((value) {
        return model = CouponModel.fromJson(jsonDecode(value));
      });
    }
    controller.refreshFailed();
    return model;
  }
}
