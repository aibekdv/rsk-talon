import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

class TokenToCacheUseCase {
  final MainRepository repository;

  TokenToCacheUseCase({required this.repository});

  Future<void> call(String token) async {
    return repository.setTokenToCache(token);
  }
}
