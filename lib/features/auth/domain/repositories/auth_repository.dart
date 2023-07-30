import 'package:rsk_talon/features/auth/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<void> login(UserEntity user);
  Future<void> register({required UserEntity user, required String successMsg});
  Future<void> activateAccount({
    required String phone,
    required String code,
    required successMsg,
  });
  Future<void> restorePassword({required String phone});
  Future<void> setRestorePassword({
    required String phone,
    required String code,
    required String password,
    required String confirmPassword,
    required String successMsg,
  });
  UserEntity? getUserFromCache();
  String? getAuthTokenFromCache();
  Future<void> refreshToken();
  Future<void> logout();
}
