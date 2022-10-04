class ReminderModel {
  final bool? status;
  final String? message;
  final List<Data>? data;

  ReminderModel({
    this.status,
    this.message,
    this.data,
  });

  ReminderModel.fromJson(Map<String, dynamic> json)
    : status = json['status'] as bool?,
      message = json['message'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final int? patientId;
  final String? pillName;
  final ReminderDates? reminderDates;
  final String? frequency;
  final String? noOfTimes;
  final String? createdAt;

  Data({
    this.id,
    this.patientId,
    this.pillName,
    this.reminderDates,
    this.frequency,
    this.noOfTimes,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      patientId = json['patient_id'] as int?,
      pillName = json['pill_name'] as String?,
      reminderDates = (json['reminder_dates'] as Map<String,dynamic>?) != null ? ReminderDates.fromJson(json['reminder_dates'] as Map<String,dynamic>) : null,
      frequency = json['frequency'] as String?,
      noOfTimes = json['no_of_times'] as String?,
      createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'patient_id' : patientId,
    'pill_name' : pillName,
    'reminder_dates' : reminderDates?.toJson(),
    'frequency' : frequency,
    'no_of_times' : noOfTimes,
    'created_at' : createdAt
  };
}

class ReminderDates {
  final String? date;

  ReminderDates({
    this.date,
  });

  ReminderDates.fromJson(Map<String, dynamic> json)
    : date = json['date'] as String?;

  Map<String, dynamic> toJson() => {
    'date' : date
  };
}