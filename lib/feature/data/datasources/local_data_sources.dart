import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rsk_talon/feature/data/models/models.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class LocalDataSources {
  Future<List<TalonEntity>> getCachedTalons();
  void talonToCache(TalonEntity talon);
  String? getCachedLanguage();
  Future<void> changeLanguage(String code);
  Future<void> deleteTalonFromCache(TalonEntity talon);
  Future<void> setTokenToCache(String token);
  Future<String?> getTokenFromCache();
}

final class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences prefs;

  LocalDataSourcesImpl({required this.prefs});

  static const TOKEN_TALON = 'TOKEN_TALON';
  static const CASHED_LANG = 'CASHED_LANG';
  static const CASHED_TALONS_LIST = 'CASHED_TALONS_LIST';

  @override
  Future<void> changeLanguage(String code) async {
    await prefs.setString(CASHED_LANG, code);
  }

  @override
  String? getCachedLanguage() {
    final code = prefs.getString(CASHED_LANG);
    if (code != null) {
      return code;
    }
    return null;
  }

  @override
  Future<List<TalonEntity>> getCachedTalons() async {
    final jsonTalonList = prefs.getStringList(CASHED_TALONS_LIST);

    if (jsonTalonList != null) {
      return Future.value(jsonTalonList
          .map((e) => TalonModel.fromJson(json.decode(e)))
          .toList());
    } else {
      return <TalonEntity>[];
    }
  }

  @override
  void talonToCache(TalonEntity talon) {
    final jsonTalonList = prefs.getStringList(CASHED_TALONS_LIST);

    final jsonTalon = TalonModel(
      id: talon.id,
      appointmentDate: talon.appointmentDate,
      token: talon.token,
      status: talon.status,
      clientType: talon.clientType,
      clientComment: talon.clientComment,
      employeeComment: talon.employeeComment,
      isPensioner: talon.isPensioner,
      registeredAt: talon.registeredAt,
      updatedAt: talon.updatedAt,
      service: talon.service,
      branch: talon.branch,
      queue: talon.queue,
      estimatedTimeInMin: talon.estimatedTimeInMin,
      qrCode: talon.qrCode,
      serviceName: talon.serviceName,
      talonsInQueue: talon.talonsInQueue,
    ).toJson();

    if (jsonTalonList == null) {
      prefs.setStringList(CASHED_TALONS_LIST, []);
      final talonListFromCache = prefs.getStringList(CASHED_TALONS_LIST);

      if (talonListFromCache != null) {
        talonListFromCache.add(jsonEncode(jsonTalon));
        prefs.setStringList(CASHED_TALONS_LIST, talonListFromCache);
      }
    } else {
      jsonTalonList.add(jsonEncode(jsonTalon));
      prefs.setStringList(CASHED_TALONS_LIST, jsonTalonList);
    }
  }

  @override
  Future<void> deleteTalonFromCache(TalonEntity talon) async {
    final jsonTalonList = prefs.getStringList(CASHED_TALONS_LIST);

    try {
      if (jsonTalonList != null) {
        jsonTalonList.remove(jsonEncode(talon));
        prefs.setStringList(CASHED_TALONS_LIST, jsonTalonList);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> setTokenToCache(String token) async {
    await prefs.remove(TOKEN_TALON);
    await prefs.setString(TOKEN_TALON, token);
  }

  @override
  Future<String?> getTokenFromCache() async {
    return prefs.getString(TOKEN_TALON);
  }
}
