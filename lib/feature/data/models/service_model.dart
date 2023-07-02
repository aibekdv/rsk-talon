import 'package:rsk_talon/feature/domain/entities/entities.dart';

final class ServiceModel extends ServiceEntity {
  ServiceModel({required super.name, required super.id});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
