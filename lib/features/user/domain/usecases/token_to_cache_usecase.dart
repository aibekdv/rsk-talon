import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class TokenToCacheUseCase {
  final MainRepository repository;

  TokenToCacheUseCase({required this.repository});

  Future<void> call(TalonEntity talon) async {
    return repository.setTokenToCache(talon);
  }
}