import 'package:rsk_talon/feature/domain/entities/entities.dart';

final class LangModel extends LangEntity {
  LangModel({
    super.id,
    super.lang,
    super.text,
  });

  factory LangModel.fromJson(Map<String, dynamic> json) {
    return LangModel(
      id: json['id'] as int,
      lang: json['lang'] as String,
      text: json['text'] as String,
    );
  }

  toJson() {
    return {
      "id": id,
      "lang": lang,
      "text": text,
    };
  }
}
