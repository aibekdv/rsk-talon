import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

final class GetCachedLangUseCase {
  final MainRepository repository;

  GetCachedLangUseCase({required this.repository});

  String? call() {
    return repository.getCachedLanguage();
  }
}
