import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

class GetTokenFromCacheUseCase {
  final MainRepository repository;

  GetTokenFromCacheUseCase({required this.repository});

  Future<String?> call() async {
    return repository.getTokenFromCache();
  }
}
