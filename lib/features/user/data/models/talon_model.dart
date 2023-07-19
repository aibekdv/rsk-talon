import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';

final class TalonModel extends TalonEntity {
  TalonModel({
    super.id,
    super.appointmentDate,
    super.qrCode,
    super.token,
    super.status,
    super.clientType,
    super.clientComment,
    super.employeeComment,
    super.isPensioner,
    super.registeredAt,
    super.updatedAt,
    super.service,
    super.branch,
    super.queue,
    super.talonsInQueue,
    super.estimatedTimeInMin,
    super.serviceName,
  });

  factory TalonModel.fromJson(Map<String, dynamic> json) {
    return TalonModel(
      id: json['id'],
      appointmentDate: json['appointment_date'],
      token: json['token'],
      qrCode: json['qr_code'],
      status: json['status'],
      clientType: json['client_type'],
      clientComment: json['client_comment'],
      employeeComment: json['employee_comment'],
      isPensioner: json['is_pensioner'],
      registeredAt: json['registered_at'],
      updatedAt: json['updated_at'],
      service: json['service'],
      branch: (json['branch'] is int)
          ? null
          : json['branch'] != null
              ? BranchModel.fromJson(json['branch'])
              : null,
      queue: json['queue'],
      talonsInQueue: json['talons_in_queue'],
      estimatedTimeInMin: json['estimated_time_in_min'],
      serviceName: json['service_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_date': appointmentDate,
      'qr_code': qrCode,
      'token': token,
      'status': status,
      'client_type': clientType,
      'client_comment': clientComment,
      'employee_comment': employeeComment,
      'is_pensioner': isPensioner,
      'registered_at': registeredAt,
      'updated_at': updatedAt,
      'service': service,
      'branch': branch,
      'queue': queue,
      'talons_in_queue': talonsInQueue,
      'estimated_time_in_min': estimatedTimeInMin,
      'service_name': serviceName,
    };
  }
}
