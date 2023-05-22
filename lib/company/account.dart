import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/dialog/virtual_acct/top_up.dart';
import 'package:doccure_patient/dialog/virtual_acct/conversion.dart';
import 'package:doccure_patient/dialog/virtual_acct/request_page.dart';
import 'package:doccure_patient/dialog/virtual_acct/withdrawal.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dialog/virtual_acct/virtual_account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String selected = 'All';
  bool isCurrencyShown = false;
  int tabIndex = 0;

  int balanceCounter = 0;
  List<dynamic> balanceAvailable = [
    {'currency': 'NGN', 'amount': '2,000,000.00', 'ledger': '1,900,000.00', 'locked': '500,000.00'},
    {'currency': 'USD', 'amount': '2,000.00', 'ledger': '1,000.00', 'locked': '500.00'},
    {'currency': 'EUR', 'amount': '4,000.00', 'ledger': '2,000.00', 'locked': '100.00'}
  ];

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
                  GestureDetector(
                      onTap: () => context.read<HomeController>().onBackPress(),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18.0,
                      )),
                  Text('Account', style: getCustomFont(color: Colors.white, size: 16.0)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                patientItem(context),
                const SizedBox(
                  height: 15.0,
                ),
                accountProcesses1(context),
                const SizedBox(
                  height: 10.0,
                ),
                accountProcesses2(context),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Recent Transactions',
                          style: getCustomFont(size: 14.0, color: Colors.black, weight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'See All',
                        style: getCustomFont(size: 13.0, color: BLUECOLOR, weight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                transactionHeader(),
                const SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ...List.generate(
                          5,
                          (index) => Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [], borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 10.0,
                                      height: 65.0,
                                      decoration: BoxDecoration(color: Colors.green.shade200.withOpacity(.9), borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), bottomLeft: Radius.circular(15.0))),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Credit card deposit(payment ID: 94943978743)',
                                              style: getCustomFont(color: BLUECOLOR, size: 12.0),
                                            ),
                                            Text(
                                              '20 Monday June, 08.48.00 GMT',
                                              style: getCustomFont(size: 11.0, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        '\$200.00',
                                        style: getCustomFont(size: 12.0, color: Colors.lightGreen, weight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                      const SizedBox(
                        height: 80.0,
                      )
                    ]),
                  ),
                )
              ],
            ),
          ))
        ]));
  }

  Widget transactionHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10.0)),
          child: Row(children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 'All';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: selected == 'All' ? BLUECOLOR : Colors.transparent),
                  child: Center(
                    child: Text('All', style: getCustomFont(size: 14.0, color: selected == 'All' ? Colors.white : BLUECOLOR)),
                  ),
                ),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 'Credit';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: selected == 'Credit' ? BLUECOLOR : Colors.transparent),
                  child: Center(
                    child: Text('Credit', style: getCustomFont(size: 14.0, color: selected == 'Credit' ? Colors.white : BLUECOLOR)),
                  ),
                ),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 'Debit';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: selected == 'Debit' ? BLUECOLOR : Colors.transparent),
                  child: Center(
                    child: Text('Debit', style: getCustomFont(size: 14.0, color: selected == 'Debit' ? Colors.white : BLUECOLOR)),
                  ),
                ),
              ),
            ),
          ]),
        ),
      );

  Widget accountProcesses1(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(children: [
              GestureDetector(
                onTap: () => showRequestSheet(context, VirtualAccount()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.green.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.account_balance, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: FittedBox(child: Text('Virtual Accts', style: getCustomFont(color: Colors.green, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, TopUp()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.purple.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Icon(Icons.monetization_on, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Text('Add Funds', style: getCustomFont(color: Colors.purple, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, RequestPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.blue.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.request_page, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Text('Request', style: getCustomFont(color: Colors.blue, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, WithdrawalPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.teal.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.money, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: FittedBox(child: Text('Withdrawal', style: getCustomFont(color: Colors.teal, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => context.read<HomeController>().setPage(-18),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.deepOrange.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: Icon(Icons.link_rounded, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: FittedBox(child: Text('Pay Links', style: getCustomFont(color: Colors.deepOrange, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2))),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ));

  Widget accountProcesses2(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(children: [
              GestureDetector(
                onTap: () => showRequestSheet(context, RequestPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.brown.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Icon(Icons.qr_code_2, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Text('Scan & Pay', style: getCustomFont(color: Colors.brown, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, ConversionPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.cyan.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.cyan,
                        child: Icon(Icons.sync, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Text('Conversion', style: getCustomFont(color: Colors.cyan, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, ConversionPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.red.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.next_plan, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pos Request', style: getCustomFont(color: Colors.red, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showRequestSheet(context, ConversionPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade100.withOpacity(.5), borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(Icons.next_plan, color: Colors.white),
                      ),
                      const SizedBox(width: 7.0),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CashBack', style: getCustomFont(color: Colors.blueGrey, size: 11.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                            Text('Coming Soon', style: getCustomFont(color: Colors.blueGrey, size: 7.0, weight: FontWeight.bold, letterSpacing: 1.2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ));

  Widget addAndTopUp(context) => Row(
        children: [
          Flexible(
              child: Visibility(
            visible: false,
            child: GestureDetector(
              onTap: () => showRequestSheet(context, TopUp()),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                dashPattern: [8, 4],
                strokeCap: StrokeCap.butt,
                color: BLUECOLOR,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wallet,
                        color: Colors.lightBlue,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: FittedBox(
                          child: Text('Wallet ', style: getCustomFont(color: Colors.black, size: 15.0, weight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => showRequestSheet(context, TopUp()),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                dashPattern: [8, 4],
                strokeCap: StrokeCap.butt,
                color: BLUECOLOR,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: FittedBox(
                      child: Text('Top Up', style: getCustomFont(color: Colors.black, size: 15.0, weight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
              child: Visibility(
            visible: false,
            child: GestureDetector(
              onTap: () => null,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                dashPattern: [8, 4],
                strokeCap: StrokeCap.butt,
                color: BLUECOLOR,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                  child: Center(
                    child: FittedBox(
                      child: Text('Request', style: getCustomFont(color: Colors.black, size: 15.0, weight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(
            width: 10.0,
          ),
        ],
      );

  Widget patientItem(context) => AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: BLUECOLOR, boxShadow: SHADOW),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () => setState(() => tabIndex = 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: FittedBox(
                            child: Text('Balances', style: getCustomFont(color: Colors.white, size: 15.0, weight: FontWeight.w500, letterSpacing: 1.2)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () => setState(() => tabIndex = 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: FittedBox(
                            child: Text('Earnings', style: getCustomFont(color: Colors.white, size: 15.0, weight: FontWeight.w500, letterSpacing: 1.2)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () => setState(() => tabIndex = 2),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: FittedBox(
                            child: Text('Requests', style: getCustomFont(color: Colors.white, size: 15.0, weight: FontWeight.w500, letterSpacing: 1.2)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25.0),
              tabIndex == 0
                  ? availableBalance()
                  : tabIndex == 1
                      ? availableEarning()
                      : availableRequest()
            ],
          ),
        ],
      ));

  Widget availableBalance() {
    return Row(
      children: [
        balanceCounter <= 0
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceAvailable.length > 0) {
                    setState(() {
                      balanceCounter--;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              ),
        SizedBox(width: balanceCounter <= 0 ? 0.0 : 20.0),
        Flexible(
            fit: FlexFit.tight,
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: getCustomFont(color: Colors.white, size: 12.0, weight: FontWeight.w400, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Flexible(
                          child: Text(isCurrencyShown ? '${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["amount"]}' : '*********',
                              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                        ),
                        const SizedBox(width: 30.0),
                        InkWell(
                          onTap: () => setState(() {
                            isCurrencyShown = !isCurrencyShown;
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isCurrencyShown ? 0.0 : 5.0),
                            child: Icon(
                              isCurrencyShown ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Text('Ledger: ', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w400, letterSpacing: 1.2)),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child:
                              Text('${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["ledger"]}', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Text('Locked: ', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w400, letterSpacing: 1.2)),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child:
                              Text('${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["locked"]}', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        balanceCounter >= (balanceAvailable.length - 1)
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceCounter < balanceAvailable.length - 1) {
                    setState(() {
                      balanceCounter++;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              )
      ],
    );
  }

  Widget availableRequest() {
    return Row(
      children: [
        balanceCounter <= 0
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceAvailable.length > 0) {
                    setState(() {
                      balanceCounter--;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              ),
        SizedBox(width: balanceCounter <= 0 ? 0.0 : 20.0),
        Flexible(
            fit: FlexFit.tight,
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Requests',
                      style: getCustomFont(color: Colors.white, size: 12.0, weight: FontWeight.w400, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Flexible(
                          child: Text(isCurrencyShown ? '${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["amount"]}' : '*********',
                              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                        ),
                        const SizedBox(width: 30.0),
                        InkWell(
                          onTap: () => setState(() {
                            isCurrencyShown = !isCurrencyShown;
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isCurrencyShown ? 0.0 : 5.0),
                            child: Icon(
                              isCurrencyShown ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Text('Ledger: ', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w400, letterSpacing: 1.2)),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child:
                              Text('${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["ledger"]}', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        balanceCounter >= (balanceAvailable.length - 1)
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceCounter < balanceAvailable.length - 1) {
                    setState(() {
                      balanceCounter++;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              )
      ],
    );
  }

  Widget availableEarning() {
    return Row(
      children: [
        balanceCounter <= 0
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceAvailable.length > 0) {
                    setState(() {
                      balanceCounter--;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              ),
        SizedBox(width: balanceCounter <= 0 ? 0.0 : 20.0),
        Flexible(
            fit: FlexFit.tight,
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tabIndex == 0 ? 'Available Balance' : 'Available Earning',
                      style: getCustomFont(color: Colors.white, size: 12.0, weight: FontWeight.w400, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Flexible(
                          child: Text(isCurrencyShown ? '${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["amount"]}' : '*********',
                              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                        ),
                        const SizedBox(width: 30.0),
                        InkWell(
                          onTap: () => setState(() {
                            isCurrencyShown = !isCurrencyShown;
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isCurrencyShown ? 0.0 : 5.0),
                            child: Icon(
                              isCurrencyShown ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7.0),
                    Row(
                      children: [
                        Text('Ledger: ', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w400, letterSpacing: 1.2)),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child:
                              Text('${balanceAvailable[balanceCounter]["currency"]} ${balanceAvailable[balanceCounter]["ledger"]}', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
        balanceCounter >= (balanceAvailable.length - 1)
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  if (balanceCounter < balanceAvailable.length - 1) {
                    setState(() {
                      balanceCounter++;
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios, color: BLUECOLOR, size: 20.0),
                  radius: 18.0,
                ),
              )
      ],
    );
  }
}
