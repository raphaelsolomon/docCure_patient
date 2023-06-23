import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant/strings.dart';
import '../model/person/user.dart';

class CompleteOnboarded extends StatefulWidget {
  const CompleteOnboarded({super.key});

  @override
  State<CompleteOnboarded> createState() => _CompleteOnboardedState();
}

class _CompleteOnboardedState extends State<CompleteOnboarded> {
  late WebViewController controller;
  final box = Hive.box<User>(BoxName);

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://gettheskydoctors.com/')) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://gettheskydoctors.com/home/patient-onboarding.html'), headers: {"Authorization": "Bearer ${box.get(USERPATH)!.token}"});
    super.initState();
  }

  late int _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _stackToView,
        children: [
          Column(
            children: <Widget>[
              Expanded(
                  child: WebViewWidget(
                controller: controller,
              )),
            ],
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
