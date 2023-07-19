import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class RemoteDataSource {
  Future<List<BranchEntity>> getAllBranches();
  Future<List<ServiceEntity>> getAllServices();
  Future<List<TalonEntity>> getAllTalons();
  Future<TalonEntity> createTalon(TalonEntity talon);
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

  static const TOKEN_TALON = 'TOKEN_TALON';
  static const CASHED_LANG = 'CASHED_LANG';
  static const CASHED_TALONS_LIST = 'CASHED_TALONS_LIST';

  @override
  Future<List<BranchEntity>> getAllBranches() async {
    try {
      var response = await dio.get(
        'http://rskseo.pythonanywhere.com/branch/list',
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

  @override
  Future<List<ServiceEntity>> getAllServices() async {
    try {
      var response = await dio.get(
        'http://rskseo.pythonanywhere.com/base/services',
        options: Options(
          headers: {'Content-Type': 'application/json'},
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
      toast(msg: e.toString());
      throw ServerExeption();
    }
  }

  @override
  Future<List<TalonEntity>> getAllTalons() async {
    try {
      var response = await dio.get(
        'http://rskseo.pythonanywhere.com/talon',
        options: Options(
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final branches = json.decode(utf8.decode(response.data));
        return branches
            .map<TalonEntity>((e) => TalonModel.fromJson(e))
            .toList();
      } else {
        toast(msg: "Server failure");
        throw ServerExeption();
      }
    } catch (e) {
      toast(msg: e.toString());
      throw ServerExeption();
    }
  }

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

    var response = await dio.post(
      'http://rskseo.pythonanywhere.com/talon/',
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.bytes,
      ),
      data: json.encode(postTalon),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = json.decode(utf8.decode(response.data));
      return TalonModel.fromJson(body);
    } else if (response.statusCode == 400) {
      final body = json.decode(utf8.decode(response.data));
      toast(
        msg: body["non_field_errors"][0].toString(),
        isError: true,
      );
      throw ServerExeption();
    } else {
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }

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

    var response = await dio.post(
      'http://rskseo.pythonanywhere.com/stats/rating/',
      options: Options(
        headers: {'Content-Type': 'application/json'},
        responseType: ResponseType.bytes,
      ),
      data: json.encode(ratingPost),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      prefs.remove(TOKEN_TALON);
      toast(msg: succesMsg);
    } else if (response.statusCode == 400) {
      log(response.data.toString());
    }
  }
}
