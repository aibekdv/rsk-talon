import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class TokenToCacheUseCase {
  final MainRepository repository;

  TokenToCacheUseCase({required this.repository});

  Future<void> call(String token) async {
    return repository.setTokenToCache(token);
  }
}
