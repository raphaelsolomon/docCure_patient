import 'dart:convert';
import 'package:hive/hive.dart';
part 'message.g.dart';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class MessageModel extends HiveObject {
  @HiveField(0)
  String? message;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? type;
  @HiveField(3)
  String? from;
  @HiveField(4)
  String? to;
  @HiveField(5)
  bool? status;
  @HiveField(6)
  bool? isRead;
  @HiveField(7)
  String? msgId;
  @HiveField(8)
  String? thumbnail;
  @HiveField(9)
  String? conversationId;
  @HiveField(10)
  String? fileSize;
  @HiveField(11)
  String? displayName;

  MessageModel({
    this.message,
    this.time,
    this.type,
    this.from,
    this.to,
    this.status,
    this.isRead,
    this.msgId,
    this.thumbnail,
    this.conversationId,
    this.fileSize,
    this.displayName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        time: json["time"],
        type: json["type"],
        from: json["from"],
        to: json["to"],
        isRead: json['isRead'],
        status: json['status'],
        msgId: json['msgId'],
        thumbnail: json['thumbnail'] ?? "",
        conversationId: json['conversationId'],
        fileSize: json['fileSize'] ?? "",
        displayName: json['displayName'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "time": time,
        "type": type,
        "from": from,
        "to": to,
        "isRead": isRead,
        "status": status,
        "msgId": msgId,
        "thumbnail": thumbnail,
        "conversationId": conversationId,
        "fileSize": fileSize,
        "displayName": displayName,
      };
}
