import 'package:rsk_talon/features/user/domain/entities/entities.dart';

final class BranchModel extends BranchEntity {
  BranchModel({
    required super.id,
    required super.city,
    required super.address,
    required super.workTimeStart,
    required super.workTimeEnd,
    required super.maxTalonWaitTime,
    required super.terminal,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      city: json['city'],
      address: json['address'],
      workTimeStart: json['work_time_start'],
      workTimeEnd: json['work_time_end'],
      maxTalonWaitTime: json['max_talon_wait_time'],
      terminal: json['terminal'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'address': address,
        'work_time_start': workTimeStart,
        'work_time_end': workTimeEnd,
        'max_talon_wait_time': maxTalonWaitTime,
        'terminal': terminal,
      };
}
