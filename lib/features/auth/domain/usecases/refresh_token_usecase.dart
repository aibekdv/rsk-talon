import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase({required this.repository});

  Future<void> call() async {
    return await repository.refreshToken();
  }
}
