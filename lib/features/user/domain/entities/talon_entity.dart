import 'package:rsk_talon/features/user/domain/entities/entities.dart';

class TalonEntity {
  int? id;
  String? appointmentDate;
  String? qrCode;
  String? token;
  String? status;
  String? clientType;
  String? clientComment;
  String? employeeComment;
  bool? isPensioner;
  String? registeredAt;
  String? updatedAt;
  int? service;
  BranchEntity? branch;
  int? queue;
  int? talonsInQueue;
  int? estimatedTimeInMin;
  String? serviceName;

  TalonEntity({
    this.id,
    this.appointmentDate,
    this.qrCode,
    this.token,
    this.status,
    this.clientType,
    this.clientComment,
    this.employeeComment,
    this.isPensioner,
    this.registeredAt,
    this.updatedAt,
    this.service,
    this.branch,
    this.queue,
    this.talonsInQueue,
    this.estimatedTimeInMin,
    this.serviceName,
  });
}
