import 'package:doccure_patient/constanst/strings.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInvoicePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const MyInvoicePage(this.scaffold, {Key? key}) : super(key: key);

  @override
  State<MyInvoicePage> createState() => _MyInvoicePageState();
}

class _MyInvoicePageState extends State<MyInvoicePage> {
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
                        Text('Invoices',
                            style:
                                getCustomFont(color: Colors.white, size: 18.0))
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
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(6, (index) => invoiceItem()),
                  const SizedBox(
                    height: 90.0,
                  ),
                ],
              ),
            ),
          ))
        ]));
  }

  Widget invoiceItem() {
    return Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: SHADOW),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  '#MR-0010',
                  style: getCustomFont(
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                )),
                Text(
                  'Paid on - 14 Mar 2022',
                  style: getCustomFont(
                      size: 15.0,
                      color: Colors.black45,
                      weight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/imgs/1.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Michelle Fairfax',
                            style: getCustomFont(
                                color: Colors.black,
                                size: 19.0,
                                weight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              '\$450',
                              style: getCustomFont(
                                  color: Colors.black,
                                  size: 13.0,
                                  weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '#PT0025',
                        style: getCustomFont(
                            color: Colors.black45,
                            size: 14.0,
                            weight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: getButton(context, () {
                            context.read<HomeController>().setPage(-14);
                          }),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget getButton(context, callBack) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: 100.0,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
            child: Center(
              child: Text(
                'View',
                style: getCustomFont(
                    size: 14.0, color: Colors.white, weight: FontWeight.normal),
              ),
            ),
          ),
        ),
      );
}
