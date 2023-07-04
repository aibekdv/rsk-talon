import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/models/models.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class RemoteDataSource {
  Future<List<BranchEntity>> getAllBranches();
  Future<List<ServiceEntity>> getAllServices();
  Future<List<TalonEntity>> getAllTalons();
  Future<TalonEntity> createTalon(TalonEntity talon);
  Future<void> downloadFileFromApi(List<String> url, String successMsg);
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;
  final SharedPreferences prefs;

  RemoteDataSourceImpl({required this.dio, required this.prefs});

  @override
  Future<List<BranchEntity>> getAllBranches() async {
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
  }

  @override
  Future<List<ServiceEntity>> getAllServices() async {
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
      toast(msg: response.data);
      throw ServerExeption();
    }
  }

  @override
  Future<List<TalonEntity>> getAllTalons() async {
    throw UnimplementedError();
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
    print(json.encode(postTalon));
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
      log(response.data);
      toast(msg: "Server failure", isError: true);
      throw ServerExeption();
    }
  }

  @override
  Future<void> downloadFileFromApi(List<String> url, String successMsg) async {
    await Permission.storage.request();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      await FileDownloader.downloadFiles(
        urls: url,
        onAllDownloaded: () {
          toast(msg: successMsg);
        },
        isParallel: false,
      );

    }

  }
}
