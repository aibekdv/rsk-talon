import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class SetRestorePasswordUseCase {
  final AuthRepository repository;

  SetRestorePasswordUseCase({required this.repository});

  Future<void> call({
    required String phone,
    required String code,
    required String password,
    required String confirmPassword,
    required String successMsg,
  }) async {
    return await repository.setRestorePassword(
      phone: phone,
      code: code,
      password: password,
      confirmPassword: confirmPassword,
      successMsg: successMsg,
    );
  }
}
