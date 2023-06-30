import 'package:rsk_talon/feature/domain/entities/entities.dart';

class TalonModel extends TalonEntity {
  TalonModel({
    super.id,
    required super.appointmentDate,
    super.token,
    super.status,
    required super.clientType,
    super.clientComment,
    super.ratingComment,
    super.employeeComment,
    super.rating,
    super.isPensioner,
    super.serviceStart,
    super.serviceEnd,
    super.registeredAt,
    super.updatedAt,
    required super.service,
    required super.branch,
    super.queue,
  });

  factory TalonModel.fromJson(Map<String, dynamic> json) {
    return TalonModel(
      id: json['id'],
      appointmentDate: json['appointment_date'],
      token: json['token'],
      status: json['status'],
      clientType: json['client_type'],
      clientComment: json['client_comment'],
      ratingComment: json['rating_comment'],
      employeeComment: json['employee_comment'],
      rating: json['rating'],
      isPensioner: json['is_pensioner'],
      serviceStart: json['service_start'],
      serviceEnd: json['service_end'],
      registeredAt: json['registered_at'],
      updatedAt: json['updated_at'],
      service: json['service'],
      branch: json['branch'],
      queue: json['queue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_date': appointmentDate,
      'token': token,
      'status': status,
      'client_type': clientType,
      'client_comment': clientComment,
      'rating_comment': ratingComment,
      'employee_comment': employeeComment,
      'rating': rating,
      'is_pensioner': isPensioner,
      'service_start': serviceStart,
      'service_end': serviceEnd,
      'registered_at': registeredAt,
      'updated_at': updatedAt,
      'service': service,
      'branch': branch,
      'queue': queue,
    };
  }
}
