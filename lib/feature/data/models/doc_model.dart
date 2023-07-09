import 'package:rsk_talon/feature/data/models/models.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';

class DocModel extends DocEntity {
  DocModel({
    required super.file,
    required super.id,
    required super.name,
    required super.required,
    required super.langNames,
  });

  factory DocModel.fromJson(Map<String, dynamic> json) {
    return DocModel(
      id: json['id'],
      name: json['name'],
      file: json['file'],
      required: json['required'],
      langNames: List.from(json['lang_name'] ?? [])
          .map((e) => LangModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'file': file,
      'required': required,
      'lang_name': langNames,
    };
  }
}
