import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/datasources/datasources.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

class MainRepositoryImpl implements MainRepository {
  final RemoteDataSource remoteDataSource;

  MainRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BranchEntity>>> getAllBranches() async =>
      await _getBranche(() => remoteDataSource.getAllBranches());

  Future<Either<Failure, List<BranchEntity>>> _getBranche(
      Future<List<BranchEntity>> Function() getBranche) async {
    try {
      final branches = await getBranche();
      return Right(branches);
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<TalonEntity>>> getAllServices() {
    throw UnimplementedError();
  }
}
