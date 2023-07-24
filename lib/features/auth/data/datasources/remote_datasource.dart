import 'package:dio/dio.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/data/models/models.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(UserEntity user);
  Future register(UserEntity user);
  Future activateAccount({required String phone, required String code});
  Future<String> refreshToken(UserEntity user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String baseUrl = 'http://rskseo.pythonanywhere.com/';

  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(UserEntity user) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: {
        'email': user.phoneNumber,
        'password': user.password,
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future activateAccount({required String phone, required String code}) async {
    // TODO: implement activateAccount
    throw UnimplementedError();
  }

  @override
  Future<String> refreshToken(UserEntity user) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future register(UserEntity user) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
