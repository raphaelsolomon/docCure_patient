import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/dialog/virtual_acct/add_link.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayLinkPage extends StatefulWidget {
  const PayLinkPage({Key? key}) : super(key: key);

  @override
  State<PayLinkPage> createState() => _PayLinkPageState();
}

class _PayLinkPageState extends State<PayLinkPage> {
  String selected = 'All';
  bool isCurrencyShown = false;

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
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                        onTap: () => context.read<HomeController>().onBackPress(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 18.0,
                        )),
                  ),
                  Text('Pay Links', style: getCustomFont(color: Colors.white, size: 16.0)),
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
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                              5,
                              (index) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
                                    decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [], borderRadius: BorderRadius.circular(5.0)),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: BLUECOLOR,
                                          child: Text('C', style: getCustomFont(color: Colors.white, size: 20.0, letterSpacing: 1.2)),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Consultion fee for budgets',
                                                style: getCustomFont(color: BLUECOLOR, size: 15.0, letterSpacing: 1.2, weight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                '20 Monday June, 08.48.00 GMT',
                                                style: getCustomFont(size: 11.0, color: Colors.black54, letterSpacing: 1.2),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text('\$200.00 NGN', style: getCustomFont(size: 12.0, color: BLUECOLOR, weight: FontWeight.w500, letterSpacing: 1.2)),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.copy, color: BLUECOLOR, size: 18.0),
                                        const SizedBox(width: 10.0),
                                      ],
                                    ),
                                  )),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: FloatingActionButton(
                            backgroundColor: BLUECOLOR,
                            onPressed: () => showRequestSheet(context, AddPayLink()),
                            child: Icon(
                              Icons.add_link,
                              color: Colors.white,
                              size: 19.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ]));
  }
}
