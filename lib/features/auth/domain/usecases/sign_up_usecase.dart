import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return await repository.register(user);
  }
}
