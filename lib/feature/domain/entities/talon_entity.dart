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
  int? branch;
  int? queue;

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
  });
}
