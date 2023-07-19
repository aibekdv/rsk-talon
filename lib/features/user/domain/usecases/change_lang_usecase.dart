import 'package:rsk_talon/features/user/domain/repositories/main_repository.dart';

final class ChangeLangUseCase {
  final MainRepository repository;

  ChangeLangUseCase({required this.repository});

  Future<void> call(String code) => repository.changeLanguage(code);
}
