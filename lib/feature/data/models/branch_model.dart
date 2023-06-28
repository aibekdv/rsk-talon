import 'package:rsk_talon/feature/domain/entities/entities.dart';

class BranchModel extends BranchEntity {
  BranchModel({
    required super.id,
    required super.city,
    required super.address,
    required super.workTimeStart,
    required super.maxTalonWaitTime,
    required super.terminal,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      city: json['city'],
      address: json['address'],
      workTimeStart: json['work_time_start'],
      maxTalonWaitTime: json['max_talon_wait_time'],
      terminal: json['terminal'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'address': address,
        'work_time_start': workTimeStart,
        'max_talon_wait_time': maxTalonWaitTime,
        'terminal': terminal,
      };
}
