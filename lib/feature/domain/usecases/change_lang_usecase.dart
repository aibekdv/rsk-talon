import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

class ChangeLangUseCase {
  final MainRepository repository;

  ChangeLangUseCase({required this.repository});

  Future<void> call(String code) => repository.changeLanguage(code);
}
