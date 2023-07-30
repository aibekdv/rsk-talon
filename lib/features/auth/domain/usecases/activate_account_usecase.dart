import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class ActivateAccountUseCase {
  final AuthRepository repository;

  ActivateAccountUseCase({required this.repository});

  Future<void> call({
    required String phone,
    required String code,
    required String successMsg,
  }) async {
    return await repository.activateAccount(
      phone: phone,
      code: code,
      successMsg: successMsg,
    );
  }
}
