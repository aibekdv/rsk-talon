import 'package:rsk_talon/feature/domain/entities/entities.dart';

import 'models.dart';

final class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.name,
    required super.id,
    required super.documents,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    documents =
        List.from(json['documents']).map((e) => DocModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['documents'] = documents?.map((e) => e.toJson()).toList();
    return data;
  }
}
