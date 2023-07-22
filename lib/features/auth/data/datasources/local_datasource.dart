import 'package:rsk_talon/features/auth/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel? getCachedUser();
  Future<void> clearCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String cachedUserKey = 'cached_user';

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) {
    final userJson = user.toJson();
    return sharedPreferences.setString(cachedUserKey, userJson);
  }

  @override
  UserModel? getCachedUser() {
    final userJson = sharedPreferences.getString(cachedUserKey);
    return userJson != null ? UserModel.fromJson(userJson) : null;
  }

  @override
  Future<void> clearCachedUser() {
    return sharedPreferences.remove(cachedUserKey);
  }
}
