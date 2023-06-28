import 'dart:convert';

import 'package:http/http.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/models/models.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';

abstract class RemoteDataSource {
  Future<List<BranchEntity>> getAllBranches();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<BranchEntity>> getAllBranches() async {
    var response = await client.get(
      Uri.parse('http://omrinori.pythonanywhere.com/branch/list'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final branches = json.decode(utf8.decode(response.bodyBytes));
      return branches.map<BranchEntity>((e) => BranchModel.fromJson(e)).toList();
    } else {
      throw ServerExeption();
    }
  }
}
