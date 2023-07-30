import 'package:rsk_talon/features/auth/data/datasources/datasources.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> login(UserEntity user) async {
    return await remoteDataSource.login(user);
  }

  @override
  Future<void> logout() => remoteDataSource.logout();

  @override
  Future<void> register({
    required UserEntity user,
    required String successMsg,
  }) async {
    return await remoteDataSource.register(user: user, successMsg: successMsg);
  }

  @override
  String? getAuthTokenFromCache() => remoteDataSource.getAuthTokenFromCache();

  @override
  UserEntity? getUserFromCache() => remoteDataSource.getUserFromCache();

  @override
  Future<void> refreshToken() async => await remoteDataSource.refreshToken();

  @override
  Future<void> activateAccount({
    required String phone,
    required String code,
    required successMsg,
  }) async =>
      await remoteDataSource.activateAccount(
        phone: phone,
        code: code,
        successMsg: successMsg,
      );

  @override
  Future<void> restorePassword({required String phone}) async =>
      await remoteDataSource.restorePassword(phone: phone);

  @override
  Future<void> setRestorePassword({
    required String phone,
    required String code,
    required String password,
    required String confirmPassword,
    required String successMsg,
  }) async =>
      await remoteDataSource.setRestorePassword(
        phone: phone,
        code: code,
        password: password,
        confirmPassword: confirmPassword,
        successMsg: successMsg,
      );
}
