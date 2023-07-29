import 'package:rsk_talon/features/auth/domain/entities/entities.dart';
import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class GetUserFromCacheUseCase {
  final AuthRepository repository;

  GetUserFromCacheUseCase({required this.repository});

  Future<UserEntity?> call() async {
    return repository.getUserFromCache();
  }
}

