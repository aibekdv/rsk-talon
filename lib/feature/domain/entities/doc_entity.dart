import 'package:rsk_talon/feature/data/models/models.dart';

class DocEntity {
  int? id;
  String? name;
  String? file;
  bool? required;
  List<LangModel>? langNames;

  DocEntity({
    this.id,
    this.name,
    this.file,
    this.required,
    this.langNames,
  });
}
