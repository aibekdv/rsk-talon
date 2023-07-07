import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/data/datasources/datasources.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

final class MainRepositoryImpl implements MainRepository {
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
  String? getCachedLanguage() => localDataSources.getCachedLanguage();

  @override
  Future<List<TalonEntity>> getCachedTalons() async =>
      await localDataSources.getCachedTalons();

  @override
  void talonToCache(TalonEntity talon) => localDataSources.talonToCache(talon);

  @override
  Future<void> deleteTalonFromCache(TalonEntity talon) async =>
      localDataSources.deleteTalonFromCache(talon);

  @override
  Future<void> downloadFileFromApi(
          List<String> url, String serviceType) async =>
      await remoteDataSource.downloadFileFromApi(url, serviceType);

  @override
  Future<String?> getTokenFromCache() async =>
      localDataSources.getTokenFromCache();

  @override
  Future<void> sendReviewToServer({
    required String token,
    required int rating,
    required String succesMsg,
  }) async =>
      remoteDataSource.sendReviewToServer(
        token: token,
        rating: rating,
        succesMsg: succesMsg,
      );

  @override
  Future<void> setTokenToCache(String token) async =>
      localDataSources.setTokenToCache(token);
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
