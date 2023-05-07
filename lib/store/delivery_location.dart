import 'package:doccure_patient/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:doccure_patient/store/confirm_order.dart';

class DeliveryLocation extends StatefulWidget {
  const DeliveryLocation({super.key});

  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

class _DeliveryLocationState extends State<DeliveryLocation> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFf6f6f6),
            child: Stack(fit: StackFit.expand, children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(target: LatLng(37.456564565, -122.67574746747), zoom: 144746),
                onMapCreated: (ctl) {
                  _controller.complete(ctl);
                },
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: BLUECOLOR,
                  child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 19.0,
                              )),
                          Text('Set Delivery Location', style: getCustomFont(size: 17.0, color: Colors.white)),
                          Icon(
                            null,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    getCardForm('Search here'),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ]),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45.0,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 19.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  '1024, Central Residency Hemilton park, USA',
                                  style: getCustomFont(size: 14.0, color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(
                              'PLATINUM LANDMARK APARTMENT ETC,',
                              style: getCustomFont(size: 14.0, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              'PLATINUM 114, First Floor, Central Residency',
                              style: getCustomFont(size: 14.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.home, color: Colors.white, size: 20.0),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Home',
                                    style: getCustomFont(size: 14.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.work, color: Colors.white, size: 20.0),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Office',
                                    style: getCustomFont(size: 14.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(50.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.map, color: Colors.white, size: 20.0),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Others',
                                    style: getCustomFont(size: 14.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => ConfirmOrder()),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          color: BLUECOLOR,
                          child: Center(
                            child: Text(
                              'Save Address',
                              style: getCustomFont(size: 14.0, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ])));
  }

  Widget getCardForm(hint, {ctl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: Colors.grey.shade200),
        child: Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.search,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: TextField(
                style: getCustomFont(size: 14.0, color: Colors.black45),
                maxLines: 1,
                decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), hintStyle: getCustomFont(size: 14.0, color: Colors.black45), border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
