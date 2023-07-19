import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'models.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.name,
    required super.id,
    required super.documents,
    required super.langNames,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      name: json['name'],
      id: json['id'],
      documents: List.from(json['documents'] ?? [])
          .map((e) => DocModel.fromJson(e))
          .toList(),
      langNames: List.from(json['lang_name'] ?? [])
          .map((e) => LangModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'documents': documents?.map((e) => e.toJson()).toList(),
      'lang_name': langNames?.map((e) => e.toJson()).toList(),
    };
  }
}
