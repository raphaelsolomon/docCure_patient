import 'dart:math';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:doccure_patient/callscreens/pickup/pick_layout.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/chat/chat_options.dart';
import 'package:doccure_patient/model/message/message.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/msg_log.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resources/call_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../dialog/subscribe.dart';

class MessageScreen extends StatefulWidget {
  final LogController logController;
  final User user;
  final Box messageBox;

  const MessageScreen(this.logController, this.user, this.messageBox, {Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool isOnline = false;
  final controller = TextEditingController();
  final box = Hive.box<User>(BoxName);
  List<MessageModel> getAllMessages = [];
  String receipent = "phoenixk54";
  bool attachmentOption = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await ChatClient.getInstance.chatManager.markAllConversationsAsRead();
      setState(() {
        getAllMessages = context.read<UserProvider>().allMessages(widget.messageBox).where((element) => element.from == receipent || element.to == receipent).toList();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage(TextEditingController _messageContent, _chatId) async {
    if (_chatId == null) {
      LogController().addLog("single chat id or message content is null");
      return;
    }
    var msg = ChatMessage.createTxtSendMessage(targetId: _chatId!, content: _messageContent.text);
    ChatClient.getInstance.chatManager.sendMessage(msg).then((value) => _messageContent.clear());
  }

  @override
  Widget build(BuildContext context) {
    getAllMessages = context.watch<UserProvider>().allMessages(widget.messageBox).where((element) => element.from == receipent || element.to == receipent).toList();
    return PickupLayout(
      user: box.get('details'),
      scaffold: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: BLUECOLOR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 92.0,
                  color: BLUECOLOR,
                  child: Column(children: [
                    context.watch<UserProvider>().showProgress
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * (context.watch<UserProvider>().progress / 100),
                            height: 2.0,
                          )
                        : const SizedBox(
                            height: 20.0,
                          ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                GestureDetector(onTap: () => Get.back(), child: Icon(Icons.keyboard_backspace, color: Colors.white)),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                CircleAvatar(
                                  radius: 18.0,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage('assets/imgs/1.png'),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text('Madeleine Penelope', style: getCustomFont(size: 16.0, color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => CallUtils.dial(context, from: box.get(USERPATH)!, to: users.first, isVideo: false),
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          GestureDetector(
                            onTap: () => CallUtils.dial(context, from: box.get(USERPATH)!, to: users.first, isVideo: true),
                            child: Icon(
                              Icons.video_call,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                      child: ListView.builder(
                          itemCount: getAllMessages.length,
                          itemBuilder: (ctx, index) {
                            return bubbleMessage(getAllMessages[index].from == 'phoenixk545', getAllMessages[index]);
                          })),
                ),
                Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
                    child: AnimatedOpacity(
                      opacity: attachmentOption ? 0 : 1,
                      duration: Duration(milliseconds: 100),
                      child: getMessageForm(
                        ctl: controller,
                        callBack: () => _sendMessage(controller, receipent),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Widget getButton(context, callBack, {text = 'Continue'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              '$text',
              style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.normal, letterSpacing: 1.2),
            ),
          ),
        ),
      );

  Widget bubbleMessage(bool isSender, MessageModel messageModel) {
    print(messageModel.type);
    if (isSender) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: messageModel.type == "TXT"
                    ? 15.0
                    : messageModel.type == "FILE"
                        ? 12.0
                        : 0.0,
                vertical: messageModel.type == "TXT"
                    ? 8.0
                    : messageModel.type == "FILE"
                        ? 7.0
                        : 0.0),
            margin: const EdgeInsets.only(left: 80.0),
            decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(messageModel.type == "FILE" ? 10.0 : 20.0)),
            child: messageModel.type == "IMAGE"
                ? ClipRRect(borderRadius: BorderRadius.circular(20.0), child: Image.network(messageModel.message!))
                : messageModel.type == "TXT"
                    ? Text(
                        messageModel.message!,
                        style: getCustomFont(size: 12.0, color: Colors.white, weight: FontWeight.w400),
                      )
                    : messageModel.type == "FILE"
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesome5.file_medical,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              const SizedBox(width: 10.0),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messageModel.displayName!,
                                        maxLines: 1,
                                        style: getCustomFont(size: 12.0, color: Colors.white, weight: FontWeight.w400),
                                      ),
                                      Text(
                                        getFileSizeString(bytes: int.parse(messageModel.fileSize!)),
                                        maxLines: 1,
                                        style: getCustomFont(size: 9.0, color: Colors.white60, weight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
          ),
          const SizedBox(
            height: 5.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${DateFormat('MMM dd, hh:mm aa').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(messageModel.time!) * 1000))}',
                    style: getCustomFont(
                      size: 9.0,
                      color: Colors.black45,
                    )),
                const SizedBox(
                  width: 3.0,
                ),
                Icon(
                  FontAwesome5.check,
                  color: Colors.black45,
                  size: 11.0,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 80.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(30.0)),
          child: Text(
            messageModel.message!,
            style: getCustomFont(size: 12.0, color: Colors.white, weight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Text('${DateFormat('MMM dd, hh:mm aa').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(messageModel.time!) * 1000))}',
                style: getCustomFont(
                  size: 9.0,
                  color: Colors.black45,
                )),
            const SizedBox(
              width: 3.0,
            ),
            Icon(
              FontAwesome5.check,
              color: Colors.black45,
              size: 11.0,
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  getMessageForm({ctl, callBack}) => Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => attachmentOption = true);
              showRequestSheet(context, ChatOptionSheet(receipent), onClose: () => setState(() => attachmentOption = false));
            },
            child: PhysicalModel(
              elevation: 10.0,
              color: BLUECOLOR,
              borderRadius: BorderRadius.circular(100.0),
              shadowColor: BLUECOLOR.withOpacity(.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Transform.rotate(
                  angle: 1.6,
                  child: Icon(
                    Icons.attachment,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          Flexible(
            child: Container(
              height: 54.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    controller: ctl,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: getCustomFont(size: 12.0, color: Colors.black45, weight: FontWeight.w400),
                    decoration: InputDecoration(
                        hintText: 'Type your message....',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        hintStyle: getCustomFont(size: 12.0, color: Colors.black45, weight: FontWeight.w400),
                        border: const OutlineInputBorder(borderSide: BorderSide.none)),
                  )),
                  GestureDetector(
                    onTap: () => callBack(),
                    child: PhysicalModel(
                      elevation: 10.0,
                      color: BLUECOLOR,
                      borderRadius: BorderRadius.circular(100.0),
                      shadowColor: BLUECOLOR.withOpacity(.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Icon(
                          Icons.send,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
