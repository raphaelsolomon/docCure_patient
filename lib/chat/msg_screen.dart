import 'package:agora_rtm/agora_rtm.dart';
import 'package:doccure_patient/chat/msg_log.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final AgoraRtmClient client;
  final LogController logController;
  final User user;
  const MessageScreen(this.client, this.logController, this.user, {Key? key})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool isOnline = false;
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.logController,
              builder: (context, List<String>log, widget) {
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemExtent: 24,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0.0),
                          title: Text(log[i]),
                        );
                      },
                      itemCount: log.length,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  void checkUserStatus() async {
    try {
      widget.client.queryPeersOnlineStatus([widget.user.uid!]).then(
          (value) => setState(() => isOnline = value[widget.user.uid]));
    } catch (errorCode) {
      if (kDebugMode) {
        print('Query error: $errorCode');
      }
    }
  }

  void _sendPeerMessage(String message) async {
    if (message.isEmpty) {
      if (kDebugMode) {
        print('Please input text to send.');
      }
      return;
    }

    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText('i hate u message');
      await widget.client.sendMessageToPeer(widget.user.uid!, message, false);
       if (kDebugMode) {
        print('Send peer message success.');
      }
    } catch (errorCode) {
      if (kDebugMode) {
        print('Query error: $errorCode');
      }
    }
  }
}
