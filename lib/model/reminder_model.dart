// To parse this JSON data, do
//
//     final reminderModel = reminderModelFromJson(jsonString);

import 'dart:convert';

ReminderModel reminderModelFromJson(String str) => ReminderModel.fromJson(json.decode(str));

String reminderModelToJson(ReminderModel data) => json.encode(data.toJson());

class ReminderModel {
  bool status;
  String message;
  List<ReminderData> data;

  ReminderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        status: json["status"],
        message: json["message"],
        data: List<ReminderData>.from(json["data"].map((x) => ReminderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReminderData {
  int id;
  String patientId;
  String pillName;
  String reminderDates;
  String frequency;
  String noOfTimes;
  DateTime createdAt;
  bool? isDeleteLoading;

  ReminderData({
    required this.id,
    required this.patientId,
    required this.pillName,
    required this.reminderDates,
    required this.frequency,
    required this.noOfTimes,
    required this.createdAt,
    this.isDeleteLoading = false,
  });

  setIsDeleteLoading(bool value) {
    this.isDeleteLoading = value;
  }

  factory ReminderData.fromJson(Map<String, dynamic> json) => ReminderData(
        id: json["id"],
        patientId: json["patient_id"],
        pillName: json["pill_name"],
        reminderDates: json["reminder_dates"],
        frequency: json["frequency"],
        noOfTimes: json["no_of_times"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "pill_name": pillName,
        "reminder_dates": reminderDates,
        "frequency": frequency,
        "no_of_times": noOfTimes,
        "created_at": createdAt.toIso8601String(),
      };
}
