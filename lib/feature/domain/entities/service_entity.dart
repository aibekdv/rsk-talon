import 'package:rsk_talon/feature/data/models/models.dart';

class ServiceEntity {
  int? id;
  String? name;
  List<DocModel>? documents;
  List<LangModel>? langNames;

  ServiceEntity({
    this.id,
    this.name,
    this.documents,
    this.langNames,
  });
}
