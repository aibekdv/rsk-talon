import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/datasources/datasources.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

class MainRepositoryImpl implements MainRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSources localDataSources;

  MainRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSources,
  });

  @override
  Future<Either<Failure, List<BranchEntity>>> getAllBranches() async =>
      await _getBranche(() => remoteDataSource.getAllBranches());

  @override
  Future<Either<Failure, List<ServiceEntity>>> getAllServices() async =>
      await _getServices(() => remoteDataSource.getAllServices());

  @override
  Future<Either<Failure, List<TalonEntity>>> getAllTalons() async =>
      await _getTalons(() => remoteDataSource.getAllTalons());

  @override
  Future<Either<Failure, TalonEntity>> createTalon(TalonEntity talon) async =>
      await _createTalon(() => remoteDataSource.createTalon(talon));

  @override
  Future<void> changeLanguage(String code) async =>
      await localDataSources.changeLanguage(code);

  @override
  String getCachedLanguage() => localDataSources.getCachedLanguage();

  @override
  Future<List<TalonEntity>> getCachedTalons() async =>
      await localDataSources.getCachedTalons();

  @override
  void talonToCache(TalonEntity talon) =>
      localDataSources.talonToCache(talon);
}

Future<Either<Failure, List<BranchEntity>>> _getBranche(
    Future<List<BranchEntity>> Function() getBranche) async {
  try {
    final branches = await getBranche();
    return Right(branches);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<ServiceEntity>>> _getServices(
    Future<List<ServiceEntity>> Function() getServices) async {
  try {
    final services = await getServices();
    return Right(services);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<TalonEntity>>> _getTalons(
    Future<List<TalonEntity>> Function() getTalons) async {
  try {
    final talons = await getTalons();
    return Right(talons);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, TalonEntity>> _createTalon(
    Future<TalonEntity> Function() createTalon) async {
  try {
    final talons = await createTalon();
    return Right(talons);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}
