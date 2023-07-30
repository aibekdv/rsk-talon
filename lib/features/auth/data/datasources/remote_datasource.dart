import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/core/error/error.dart';
import 'package:rsk_talon/features/auth/data/models/models.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  AuthRemoteDataSourceImpl({required this.dio, required this.prefs});

  startRefreshToken(Timer timer) async {
    log("old token: ${prefs.getString(AppConsts.ACCESS_TOKEN)}");
    await refreshToken();
    log("new token: ${prefs.getString(AppConsts.ACCESS_TOKEN)}");
  }

// Login user
  @override
  Future<void> login(UserEntity user) async {
    try {
      final response = await dio.post(
        '/client/login/',
        data: {
          "phone": user.phoneNumber,
          "password": user.password,
        },
      );

      // CHECK STATUS CODE
      if (response.statusCode == 200 || response.statusCode == 201) {
        prefs.setString(
          AppConsts.USER,
          jsonEncode(
            UserModel(
              phoneNumber: user.phoneNumber,
              password: user.password,
            ).toJson(),
          ),
        );
        prefs.setString(AppConsts.ACCESS_TOKEN, response.data["access_token"]);
        prefs.setString(
          AppConsts.REFRESH_TOKEN,
          response.data["refresh_token"],
        );

        Timer.periodic(const Duration(minutes: 19), startRefreshToken);
      }
    } catch (e) {
      // CHECKING DIO EXCEPTION
      if (e is DioException) {
        if (e.response!.statusCode! > 400 && e.response!.statusCode! < 405) {
          toast(
            msg: "Unauthorized: ${e.response!.data['error']}",
            isError: true,
          );
          throw ServerExeption();
        }
        toast(msg: "Server failure", isError: true);
        throw ServerExeption();
      } else {
        toast(msg: e.toString(), isError: true);
        throw ServerExeption();
      }
    }
  }

// Logout user
  @override
  Future<void> logout() async {
    await prefs.remove(AppConsts.REFRESH_TOKEN);
    await prefs.remove(AppConsts.ACCESS_TOKEN);
    await prefs.remove(AppConsts.USER);
  }

// Register user
  @override
  Future<void> register({
    required UserEntity user,
    required String successMsg,
  }) async {
    try {
      Response response = await dio.post(
        '/client/registration/',
        data: {
          "phone": user.phoneNumber,
          "password": user.password,
          "password_confirm": user.confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        toast(msg: successMsg);
      }
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
        // log(e.response!.data.toString());
      }
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }

// Get Access Token after login and write that token to cache
  @override
  String? getAuthTokenFromCache() {
    return prefs.getString(AppConsts.ACCESS_TOKEN);
  }

// Get user info from cache with SharedPreference
  @override
  UserEntity? getUserFromCache() {
    var res = prefs.getString(AppConsts.USER);
    if (res != null) {
      return UserModel.fromJson(json.decode(res));
    } else {
      return null;
    }
  }

// Refresh Token
  @override
  Future<void> refreshToken() async {
    try {
      var refToken = prefs.getString(AppConsts.REFRESH_TOKEN);
      var response = await dio.post('/client/token/refresh/', data: {
        "refresh_token": refToken,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        await prefs.setString(
            AppConsts.ACCESS_TOKEN, response.data["access_token"]);
        var access = prefs.getString(AppConsts.ACCESS_TOKEN);
        log("access new: $access");
      }
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
      }
      throw ServerExeption();
    }
  }

  // Activate account with specific code
  @override
  Future<void> activateAccount({
    required String phone,
    required String code,
    required successMsg,
  }) async {
    try {
      var response = await dio.post('/client/activate/', data: {
        "phone": phone,
        "code": code,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        toast(msg: successMsg);
      }
    } catch (e) {
      toast(msg: "Incorrect code :)", isError: true);
      log("Activate account error: $e");
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }

  // Restore password with phone number
  @override
  Future<void> restorePassword({required String phone}) async {
    try {
      var response = await dio.post('/client/restore-password/', data: {
        "phone": phone,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
      }
    } catch (e) {
      log("Restore password error: $e");
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }

  // Set resoted password
  @override
  Future<void> setRestorePassword({
    required String phone,
    required String code,
    required String password,
    required String confirmPassword,
    required String successMsg,
  }) async {
    try {
      var response = await dio.post('/client/set-restored-password/', data: {
        "phone": phone,
        "code": code,
        "new_password": password,
        "new_pass_confirm": confirmPassword,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        toast(msg: successMsg);
        log("Restored password body: ${response.data}");
      }
    } catch (e) {
      log("Activate account error: $e");
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }
}
