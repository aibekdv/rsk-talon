
import 'package:dio/dio.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/data/models/models.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  // Other API calls related to authentication
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const String baseUrl = 'https://your_api_base_url.com/auth'; // Replace with your actual API base URL

  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerExeption(); // Custom exception to handle server errors
    }
  }

  // Implement other API calls for registration, user details, etc.
}
