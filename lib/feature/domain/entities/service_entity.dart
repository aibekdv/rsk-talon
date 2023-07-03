import 'package:rsk_talon/feature/data/models/models.dart';

class ServiceEntity {
  int? id;
  String? name;
  List<DocModel>? documents;

  ServiceEntity({this.id, this.name, this.documents});
}
