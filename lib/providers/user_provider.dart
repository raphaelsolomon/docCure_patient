import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:doccure_patient/model/call.dart';
import 'package:doccure_patient/model/message/message.dart';
import 'package:doccure_patient/model/person/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  Map<String, dynamic> profile = {};
  String agoraAppToken = "";
  List<MessageModel> getAllMessages = [];
  int progress = 0;
  bool showProgress = false;

  Call? call;

  User get getUser => _user!;

  setProfile(data) {
    this.profile = data;
  }

  setUser(user) {
    this._user = user;
  }

  setCall(Map<String, dynamic> callUser) {
    this.call = Call.fromMap(callUser);
  }

  setAgoraAppToken(String appToken) {
    this.agoraAppToken = appToken;
  }

  Call get getCall => call!;

  setMessage(ChatMessage message, Box messageBox, bool status) {
    print(message.toJson());
    if (message.body.type == MessageType.IMAGE) {
      ChatImageMessageBody body = message.body as ChatImageMessageBody;
      getAllMessages.add(MessageModel(
          message: body.remotePath,
          time: '${DateTime.now().millisecondsSinceEpoch}',
          type: message.body.type.name,
          from: '${message.from}',
          to: message.to,
          status: status,
          isRead: message.hasRead,
          msgId: message.msgId,
          conversationId: message.conversationId,
          fileSize: '${body.fileSize}',
          displayName: body.displayName,
          thumbnail: body.thumbnailLocalPath));
    } else if (message.body.type == MessageType.TXT) {
      ChatTextMessageBody body = message.body as ChatTextMessageBody;
      getAllMessages.add(MessageModel(
          message: body.content,
          time: '${DateTime.now().millisecondsSinceEpoch}',
          type: message.body.type.name,
          from: '${message.from}',
          to: message.to,
          status: status,
          isRead: message.hasRead,
          msgId: message.msgId,
          thumbnail: "",
          conversationId: message.conversationId));
    } else if (message.body.type == MessageType.FILE) {
      ChatFileMessageBody body = message.body as ChatFileMessageBody;
      getAllMessages.add(MessageModel(
          message: body.remotePath,
          time: '${DateTime.now().millisecondsSinceEpoch}',
          type: message.body.type.name,
          from: '${message.from}',
          to: message.to,
          status: status,
          isRead: message.hasRead,
          msgId: message.msgId,
          fileSize: '${body.fileSize}',
          displayName: body.displayName,
          conversationId: message.conversationId,
          thumbnail: ""));
    } else if (message.body.type == MessageType.VOICE) {
      ChatVoiceMessageBody body = message.body as ChatVoiceMessageBody;
      getAllMessages.add(MessageModel(
          message: body.remotePath,
          time: '${DateTime.now().millisecondsSinceEpoch}',
          type: message.body.type.name,
          from: '${message.from}',
          to: message.to,
          status: status,
          isRead: message.hasRead,
          msgId: message.msgId,
          fileSize: '${body.fileSize}',
          displayName: body.displayName,
          conversationId: message.conversationId,
          thumbnail: ""));
    } else if (message.body.type == MessageType.VIDEO) {
      ChatVideoMessageBody body = message.body as ChatVideoMessageBody;
      getAllMessages.add(MessageModel(
          message: body.remotePath,
          time: '${DateTime.now().millisecondsSinceEpoch}',
          type: message.body.type.name,
          from: '${message.from}',
          to: message.to,
          status: status,
          isRead: message.hasRead,
          msgId: message.msgId,
          fileSize: '${body.fileSize}',
          conversationId: message.conversationId,
          displayName: body.displayName,
          thumbnail: body.thumbnailLocalPath));
    }
    messageBox.put('chatDB', messageModelToJson(getAllMessages)).then((value) {
      this.progress = 0;
      this.showProgress = false;
    });
    notifyListeners();
  }

  setMessageProcessing(int progress) {
    if (!this.showProgress) this.showProgress = true;
    this.progress = progress;
    print(this.progress);
    notifyListeners();
  }

  List<MessageModel> allMessages(Box messageBox) {
    // print(messageBox.get('chatDB'));
    getAllMessages = messageModelFromJson(messageBox.get('chatDB', defaultValue: '[]'));
    return getAllMessages;
  }
}
