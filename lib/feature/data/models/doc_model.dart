import 'package:rsk_talon/feature/domain/entities/entities.dart';

final class DocModel extends DocEntity {
  DocModel({
    super.file,
    super.id,
    super.name,
    super.required,
  });

  DocModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file'] = file;
    data['required'] = required;
    return data;
  }
}
