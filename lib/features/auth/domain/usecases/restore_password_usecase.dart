import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class RestorePasswordUseCase {
  final AuthRepository repository;

  RestorePasswordUseCase({required this.repository});

  Future<void> call(String phone) async {
    return await repository.restorePassword(phone: phone);
  }
}
