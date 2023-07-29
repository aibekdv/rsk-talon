import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class GetTokenFromCacheUseCase {
  final MainRepository repository;

  GetTokenFromCacheUseCase({required this.repository});

  Future<String?> call() async {
    return repository.getTokenFromCache();
  }
}