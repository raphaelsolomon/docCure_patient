import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:doccure_patient/auth/change_password.dart';
import 'package:doccure_patient/callscreens/pickup/pick_layout.dart';
import 'package:doccure_patient/chat/chat_list.dart';
import 'package:doccure_patient/company/account.dart';
import 'package:doccure_patient/company/favourite.dart';
import 'package:doccure_patient/company/invoice_receipt.dart';
import 'package:doccure_patient/company/myoffer.dart';
import 'package:doccure_patient/company/myprescription.dart';
import 'package:doccure_patient/company/myreferral.dart';
import 'package:doccure_patient/company/notification.dart';
import 'package:doccure_patient/company/notificationsetting.dart';
import 'package:doccure_patient/company/profilesettings.dart';
import 'package:doccure_patient/company/rateus.dart';
import 'package:doccure_patient/company/shareapp.dart';
import 'package:doccure_patient/company/socialmedia.dart';
import 'package:doccure_patient/company/support.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:doccure_patient/dialog/subscribe.dart';
import 'package:doccure_patient/dialog/virtual_acct/pay_link.dart';
import 'package:doccure_patient/homepage/doctor_profile.dart';
import 'package:doccure_patient/homepage/find_doctors.dart';
import 'package:doccure_patient/homepage/home.dart';
import 'package:doccure_patient/homepage/invoice.dart';
import 'package:doccure_patient/homepage/myfamily.dart';
import 'package:doccure_patient/homepage/new_home_page.dart';
import 'package:doccure_patient/homepage/patient_profile.dart';
import 'package:doccure_patient/homepage/reminder.dart';
import 'package:doccure_patient/homepage/search_doctor.dart';
import 'package:doccure_patient/homepage/time_and_date.dart';
import 'package:doccure_patient/homepage/vital_and_tracks.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:doccure_patient/providers/msg_log.dart';
import 'package:doccure_patient/providers/page_controller.dart';
import 'package:doccure_patient/providers/user_provider.dart';
import 'package:doccure_patient/resources/call_methods.dart';
import 'package:doccure_patient/resuable/custom_nav.dart';
import 'package:doccure_patient/resuable/form_widgets.dart';
import 'package:doccure_patient/services/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  LogController logController = LogController();
  final CallMethods callMethods = CallMethods();
  final scaffold = GlobalKey<ScaffoldState>();
  final box = Hive.box<User>(BoxName);
  final messageBox = Hive.box(BOXMESSAGEBOX);

  ChatOptions options = ChatOptions(
    appKey: '71376350#1118140',
    autoLogin: false,
    requireAck: true,
    requireDeliveryAck: true,
    isAutoDownloadThumbnail: true,
  );

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      //initialize agora sdk and sign in user
      options.enableFCM("898273018789");
      options.enableAPNs("898273018789");
      await ChatClient.getInstance.init(options);
      await ChatClient.getInstance.startCallback();
      _addChatListener();
      ApiServices.getChatUserToken('phoenixk545').then((value) => _signInAgoraChat('phoenixk545', value));
      //==============on token refresh and token get=========
      //onRefreshToken();
      if (box.get(USERPATH) != null) {
        context.read<UserProvider>().setUser(box.get(USERPATH));
        final response = await ApiServices.getProfile(box.get(USERPATH)!.token);
        context.read<UserProvider>().setProfile(response);
      }
      dialogMessage(context, subscribe(context));
    });
    super.initState();
  }

  void _signInAgoraChat(String userID, String token) async {
    try {
      await ChatClient.getInstance.loginWithAgoraToken(userID, token);
      logController.addLog('==========login succcess, userID: ${box.get(USERPATH)!.uid!}');
    } on ChatError catch (e) {
      print('login failed, code: ${e.code}, desc: ${e.description}');
    }
  }

  void _addChatListener() {
    ChatClient.getInstance.contactManager.addEventHandler(
        "UNIQUE_HANDLER_ID",
        ContactEventHandler(
          onContactInvited: (userId, reason) {
            print('${userId} ${reason}');
          },
          onFriendRequestDeclined: (userId) {
            print('${userId} declined');
          },
        ));
    // Adds message status changed event.
    ChatClient.getInstance.chatManager.addMessageEvent(
        "UNIQUE_HANDLER_ID",
        ChatMessageEvent(onSuccess: (msgId, msg) {
          //   LogController().addLog("send message onSuccess");
          context.read<UserProvider>().setMessage(msg, messageBox, true);
        }, onProgress: (msgId, progress) {
          //  LogController().addLog("send message onProgress ${progress}");
          context.read<UserProvider>().setMessageProcessing(progress);
        }, onError: (msgId, msg, error) {
          LogController().addLog("send message failed, code: ${error.code}, desc: ${error.description}");
          context.read<UserProvider>().setMessage(msg, messageBox, false);
        }));

    ChatClient.getInstance.chatManager.addEventHandler(
        "UNIQUE_HANDLER_ID",
        ChatEventHandler(
            onMessagesDelivered: (messages) {},
            onMessagesRead: (messages) {},
            onMessagesRecalled: (messages) {},
            onMessagesReceived: (messages) {
              for (var msg in messages) {
                switch (msg.body.type) {
                  case MessageType.TXT:
                    ChatTextMessageBody body = msg.body as ChatTextMessageBody;
                    LogController().addLog("receive text message: ${body.content}, from: ${msg.from}");
                    context.read<UserProvider>().setMessage(msg, messageBox, true);
                    break;
                  case MessageType.IMAGE:
                    ChatClient.getInstance.chatManager.downloadThumbnail(msg);
                    ChatImageMessageBody imgBody = msg.body as ChatImageMessageBody;
                    String? thumbnailLocalPath = imgBody.thumbnailLocalPath;
                    LogController().addLog("receive text message: ${imgBody.localPath}, from: ${msg.from}, thumbnail: ${thumbnailLocalPath}");
                    break;
                  case MessageType.VIDEO:
                    ChatClient.getInstance.chatManager.downloadThumbnail(msg);
                    ChatImageMessageBody imgBody = msg.body as ChatImageMessageBody;
                    String? thumbnailLocalPath = imgBody.thumbnailLocalPath;
                    break;
                  case MessageType.LOCATION:
                    break;
                  case MessageType.VOICE:
                    break;
                  case MessageType.FILE:
                    ChatClient.getInstance.chatManager.downloadAttachment(msg);
                    ChatFileMessageBody fileBody = msg.body as ChatFileMessageBody;
                    String? localPath = fileBody.localPath;

                    break;
                  case MessageType.CMD:
                    break;
                  case MessageType.CUSTOM:
                    break;
                }
              }
            }));
  }

  @override
  void dispose() async {
    print('================onDispose========================');
    _signOut();
    context.read<UserProvider>().getCall.channelId == null ? null : await callMethods.endCall(call: context.read<UserProvider>().getCall);
    super.dispose();
  }

  void _signOut() async {
    try {
      await ChatClient.getInstance.logout(true);
      ChatClient.getInstance.chatManager.removeMessageEvent("UNIQUE_HANDLER_ID");
      ChatClient.getInstance.contactManager.removeEventHandler("UNIQUE_HANDLER_ID");
      ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
    } on ChatError catch (e) {
      print("sign out failed, code: ${e.code}, desc: ${e.description}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = context.watch<HomeController>().getPage;
    print(box.get(USERPATH)!.profilePhoto);
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) => WillPopScope(
        onWillPop: () => context.read<HomeController>().onBackPress(),
        child: PickupLayout(
            user: box.get('details'),
            scaffold: Scaffold(
                key: scaffold,
                resizeToAvoidBottomInset: true,
                drawer: !removeBottom.contains(page) ? navDrawer(context, scaffold, box) : null,
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    page == 0
                        ? AllHomePage(scaffold)
                        : page == 10
                            ? HomePage(scaffold)
                            : page == 12 //no bottom nav
                                ? NotificationPage()
                                : page == 1 //no bottom nav
                                    ? VitalAndTracks(scaffold)
                                    : page == 5
                                        ? ChatListScreen(scaffold, logController, messageBox)
                                        : page == 6
                                            ? MyInvoicePage()
                                            : page == 7 //no bottom nav
                                                ? MyFamily()
                                                : page == 8 //no bottom nav
                                                    ? MyReminder()
                                                    : page == 9 //no bottom nav
                                                        ? MyReferrals()
                                                        : page == -4 //no bottom nav
                                                            ? DoctorProfile(scaffold)
                                                            : page == -5 //no bottom nav
                                                                ? NotificationSettingsPage()
                                                                : page == -6 //no bottom nav
                                                                    ? RateUS()
                                                                    : page == -7 //no bottom nav
                                                                        ? ShareApp()
                                                                        : page == -8 //no bottom nav
                                                                            ? AuthChangePass()
                                                                            : page == -9 //no bottom nav
                                                                                ? SupportPage()
                                                                                : page == -10
                                                                                    ? MyProfile(scaffold)
                                                                                    : page == -11
                                                                                        ? Prescriptions(scaffold)
                                                                                        : page == -12 //no bottom nav
                                                                                            ? MyOffer()
                                                                                            : page == -17
                                                                                                ? MyFavourite()
                                                                                                : page == -3
                                                                                                    ? SearchDoctor(scaffold)
                                                                                                    : page == -1 //no bottom nav
                                                                                                        ? TimeAndDate(scaffold)
                                                                                                        : page == -2 //no bottom nav
                                                                                                            // ? ProfileSettings(scaffold)
                                                                                                            ? ProfileSettings(scaffold)
                                                                                                            : page == -14
                                                                                                                ? InvoiceReceipt(scaffold)
                                                                                                                : page == -16
                                                                                                                    ? FindDoctorsPage(scaffold)
                                                                                                                    : page == -13
                                                                                                                        ? SocialMedia(scaffold)
                                                                                                                        : page == -18
                                                                                                                            ? PayLinkPage()
                                                                                                                            : AccountPage(),
                    !isVisible && (!removeBottom.contains(page) && !removeBottom1.contains(page))
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomNavBar(
                              context,
                              pageIndex: 0,
                            ))
                        : SizedBox()
                  ],
                ))),
      ),
    );
  }
}
