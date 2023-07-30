import 'dart:convert';

import 'package:rsk_talon/common/values/values.dart';
import 'package:rsk_talon/core/error/error.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class LocalDataSources {
  String? getCachedLanguage();
  Future<void> changeLanguage(String code);
  Future<void> setTokenToCache(TalonEntity talon);
  Future<String?> getTokenFromCache();
}

final class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences prefs;

  LocalDataSourcesImpl({required this.prefs});

  // CHANGE LANGUAGE AND WRITE TO CACHE
  @override
  Future<void> changeLanguage(String code) async {
    await prefs.setString(AppConsts.CASHED_LANG, code);
  }

  // GET LANGUAGE CODE FROM CACHE
  @override
  String? getCachedLanguage() {
    try {
      final code = prefs.getString(AppConsts.CASHED_LANG);
      if (code != null) {
        return code;
      }
      return null;
    } catch (e) {
      throw CacheExeption();
    }
  }

  // SET TALON TOKEN FOR SEND REVIEW TO SERVERS
  @override
  Future<void> setTokenToCache(TalonEntity talon) async {
    await prefs.remove(AppConsts.TOKEN_TALON);
    await prefs.setString(AppConsts.TOKEN_TALON, jsonEncode(talon));
  }

  // GET TALON TOKEN FROM CACHE FOR SEND REVIEW TO SERVER
  @override
  Future<String?> getTokenFromCache() async {
    return prefs.getString(AppConsts.TOKEN_TALON);
  }
}
