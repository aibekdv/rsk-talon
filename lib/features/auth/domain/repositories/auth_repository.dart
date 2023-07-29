import 'package:rsk_talon/features/auth/domain/entities/entities.dart';

abstract class AuthRepository {
  Future<void> login(UserEntity user);
  Future<void> register(UserEntity user);
  String? getAuthTokenFromCache();
  UserEntity? getUserFromCache();
  Future<void> refreshToken();
  Future<void> logout();
}
