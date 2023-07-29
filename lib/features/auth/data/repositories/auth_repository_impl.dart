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
  Future<void> register(UserEntity user) async {
    return await remoteDataSource.register(user);
  }

  @override
  String? getAuthTokenFromCache() => remoteDataSource.getAuthTokenFromCache();

  @override
  UserEntity? getUserFromCache() => remoteDataSource.getUserFromCache();

  @override
  Future<void> refreshToken() async =>
      await remoteDataSource.refreshToken();
}
