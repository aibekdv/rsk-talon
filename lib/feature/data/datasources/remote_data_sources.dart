import 'dart:convert';

import 'package:http/http.dart';
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
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final Client client;
  final SharedPreferences prefs;

  RemoteDataSourceImpl({required this.client, required this.prefs});

  @override
  Future<List<BranchEntity>> getAllBranches() async {
    var response = await client.get(
      Uri.parse('http://omrinori.pythonanywhere.com/branch/list'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final branches = json.decode(utf8.decode(response.bodyBytes));
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
    var response = await client.get(
      Uri.parse('http://omrinori.pythonanywhere.com/base/services'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final branches = json.decode(utf8.decode(response.bodyBytes));
      return branches
          .map<ServiceEntity>((e) => ServiceModel.fromJson(e))
          .toList();
    } else {
      toast(msg: response.body);
      throw ServerExeption();
    }
  }

  @override
  Future<List<TalonEntity>> getAllTalons() async {
    throw UnimplementedError();
    /*var response = await client.get(
      Uri.parse('http://omrinori.pythonanywhere.com/talon/'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final branches = json.decode(utf8.decode(response.bodyBytes));
      return branches.map<TalonEntity>((e) => TalonModel.fromJson(e)).toList();
    } else {
      toast(msg: response.body);
      throw ServerExeption();
    }*/
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
    var response = await client.post(
      Uri.parse('http://omrinori.pythonanywhere.com/talon/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(postTalon),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final branch = json.decode(utf8.decode(response.bodyBytes));
      return TalonModel.fromJson(branch);
    } else if (response.statusCode == 400) {
      final branch = json.decode(utf8.decode(response.bodyBytes));
      toast(
        msg: branch["non_field_errors"][0].toString(),
        isError: true,
      );
      throw ServerExeption();
    } else {
      throw ServerExeption();
    }
  }
}
