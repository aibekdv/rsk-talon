import 'package:rsk_talon/feature/domain/entities/entities.dart';

class TalonEntity {
  int? id;
  String? appointmentDate;
  String? token;
  String? status;
  String? clientType;
  String? clientComment;
  String? ratingComment;
  String? employeeComment;
  int? rating;
  bool? isPensioner;
  String? serviceStart;
  String? serviceEnd;
  String? registeredAt;
  String? updatedAt;
  int? service;
  BranchEntity? branch;
  int? queue;
  int? branchId;

  TalonEntity({
    this.id,
    this.appointmentDate,
    this.token,
    this.status,
    this.clientType,
    this.clientComment,
    this.ratingComment,
    this.employeeComment,
    this.rating,
    this.isPensioner,
    this.serviceStart,
    this.serviceEnd,
    this.registeredAt,
    this.updatedAt,
    this.service,
    this.branch,
    this.queue,
    this.branchId,
  });
}
