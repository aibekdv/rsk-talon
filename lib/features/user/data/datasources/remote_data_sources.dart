import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class RemoteDataSource {
  Future<List<BranchEntity>> getAllBranches();
  Future<List<ServiceEntity>> getAllServices();
  Future<TalonEntity> createTalon(TalonEntity talon);
  Future<List<TalonEntity>> getUserTalons();
  Future<void> removeTalonFromServer(TalonEntity talon, {required String msg});
  Future<UserEntity?> getUserInforFromCache();

  Future<void> sendReviewToServer({
    required String token,
    required int rating,
    required String succesMsg,
  });
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  RemoteDataSourceImpl({required this.dio, required this.prefs});

  // GET ALL BRANCHES FROM SERVER
  @override
  Future<List<BranchEntity>> getAllBranches() async {
    try {
      var response = await dio.get(
        '/branch/list/',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final branches = json.decode(utf8.decode(response.data));
        return branches
            .map<BranchEntity>((e) => BranchModel.fromJson(e))
            .toList();
      } else {
        toast(msg: "Server failure", isError: true);
        throw ServerExeption();
      }
    } catch (e) {
      toast(msg: "$e", isError: true);
      throw ServerExeption();
    }
  }

  // GET ALL SERVICES FROM SERVER
  @override
  Future<List<ServiceEntity>> getAllServices() async {
    try {
      var response = await dio.get(
        '/base/services',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${prefs.getString(AppConsts.ACCESS_TOKEN)}',
          },
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final branches = json.decode(utf8.decode(response.data));
        return branches
            .map<ServiceEntity>((e) => ServiceModel.fromJson(e))
            .toList();
      } else {
        toast(msg: 'Server failure');
        throw ServerExeption();
      }
    } catch (e) {
      if (e is DioException) {
        toast(msg: e.message.toString(), isError: true);
      }
      throw ServerExeption();
    }
  }

  // CREATE TALON FOR CURRENT ${USER}
  @override
  Future<TalonEntity> createTalon(TalonEntity talon) async {
    final Map<String, dynamic> postTalon = {
      "client_type": talon.clientType,
      "service": talon.service,
      "branch": talon.branch!.id,
      "is_pensioner": talon.isPensioner,
      if (talon.appointmentDate != null)
        "appointment_date": talon.appointmentDate,
    };

    try {
      var response = await dio.post(
        '/talon/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${prefs.getString(AppConsts.ACCESS_TOKEN)}',
          },
          responseType: ResponseType.bytes,
        ),
        data: json.encode(postTalon),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = json.decode(utf8.decode(response.data));
        return TalonModel.fromJson(body);
      } else {
        toast(msg: "Server failure", isError: true);
        throw ServerExeption();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final body = json.decode(utf8.decode(e.response?.data));
        toast(
          msg: body["non_field_errors"][0].toString(),
          isError: true,
        );
      } else {
        toast(msg: "Server failure", isError: true);
        throw ServerExeption();
      }
      throw ServerExeption();
    }
  }

  // SEND REVIEW TO SERVER
  @override
  Future<void> sendReviewToServer({
    required String token,
    required int rating,
    required String succesMsg,
  }) async {
    Map<String, dynamic> ratingPost = {
      "token": token,
      "rating": rating,
    };

    try {
      var response = await dio.post(
        '/stats/rating/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${prefs.getString(AppConsts.ACCESS_TOKEN)}',
          },
          responseType: ResponseType.bytes,
        ),
        data: json.encode(ratingPost),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        prefs.remove(AppConsts.TOKEN_TALON);
        toast(msg: succesMsg);
      } else if (response.statusCode == 400) {
        log(response.data.toString());
      }
    } on DioException catch (e) {
      toast(
        msg: e.response!.data.toString(),
        isError: true,
      );
    }
  }

  // GET CURRENT USER'S TALONS
  @override
  Future<List<TalonEntity>> getUserTalons() async {
    try {
      var response = await dio.get(
        '/client/talons',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${prefs.getString(AppConsts.ACCESS_TOKEN)}',
          },
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final branches = json.decode(utf8.decode(response.data));
        return branches
            .map<TalonEntity>((e) => TalonModel.fromJson(e))
            .toList();
      } else {
        toast(msg: 'Server failure');
        throw ServerExeption();
      }
    } catch (e) {
      if (e is DioException) {
        toast(msg: e.message.toString(), isError: true);
      }
      log(e.toString());
      throw ServerExeption();
    }
  }

  // REMOVE TALON FROM SERVER
  @override
  Future<void> removeTalonFromServer(TalonEntity talon,
      {required String msg}) async {
    try {
      var response = await dio.delete(
        '/client/talon-delete/${talon.id!}/',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            // BEARER TOKEN
            'Authorization':
                'Bearer ${prefs.getString(AppConsts.ACCESS_TOKEN)}',
          },
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        toast(msg: msg);
      } else {
        toast(msg: "Server failure", isError: true);
        throw ServerExeption();
      }
    } catch (e) {
      toast(msg: "$e", isError: true);
      throw ServerExeption();
    }
  }

  @override
  Future<UserEntity?> getUserInforFromCache() async {
    try {
      final user = prefs.getString(AppConsts.USER);
      UserEntity userInfo = jsonDecode(user!);
      return userInfo;
    } catch (e) {
      log("Cache error: $e");
      throw CacheExeption();
    }
  }
}
