import 'dart:math';

class PrescriptionModel {
  final bool? status;
  final String? message;
  final List<PrescriptionData>? data;

  PrescriptionModel({
    this.status,
    this.message,
    this.data,
  });

  PrescriptionModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => PrescriptionData.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'status': status, 'message': message, 'data': data?.map((e) => e.toJson()).toList()};
}

PrescriptionModel dummyData() {
  return PrescriptionModel(message: '', status: null, data: [
    PrescriptionData(id: Random().nextInt(20000), doctorName: 'John Deo', specialization: 'Neurosurgeon', patientId: '3243', name: 'Phoenix King', quantity: '3', days: '3', time: ['10:00am, 11:00am, 12:00am, 13:00am'], createdAt: '2023-03-09'),
    PrescriptionData(id: Random().nextInt(20000), doctorName: 'John Deo', specialization: 'Neurosurgeon', patientId: '3243', name: 'Phoenix King', quantity: '3', days: '3', time: ['10:00am, 11:00am, 12:00am, 13:00am'], createdAt: '2023-03-09'),
    PrescriptionData(id: Random().nextInt(20000), doctorName: 'John Deo', specialization: 'Neurosurgeon', patientId: '3243', name: 'Phoenix King', quantity: '3', days: '3', time: ['10:00am, 11:00am, 12:00am, 13:00am'], createdAt: '2023-03-09'),
  ]);
}

class PrescriptionData {
  final int? id;
  final String? doctorName;
  final String? specialization;
  final dynamic patientId;
  final String? name;
  final String? quantity;
  final String? days;
  final List<String>? time;
  final String? signature;
  final String? createdAt;

  PrescriptionData({
    this.id,
    this.doctorName,
    this.specialization,
    this.patientId,
    this.name,
    this.quantity,
    this.days,
    this.time,
    this.signature,
    this.createdAt,
  });

  PrescriptionData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        doctorName = json['doctor_name'] as String?,
        specialization = json['specialization'] as String?,
        patientId = json['patient_id'],
        name = json['name'] as String?,
        quantity = json['quantity'] as String?,
        days = json['days'] as String?,
        time = (json['time'] as List?)?.map((dynamic e) => e as String).toList(),
        signature = json['signature'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'doctor_name': doctorName, 'specialization': specialization, 'patient_id': patientId, 'name': name, 'quantity': quantity, 'days': days, 'time': time, 'signature': signature, 'created_at': createdAt};
}
