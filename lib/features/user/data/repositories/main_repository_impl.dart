import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/user/data/datasources/datasources.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

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
  Future<Either<Failure, TalonEntity>> createTalon(TalonEntity talon) async =>
      await _createTalon(() => remoteDataSource.createTalon(talon));

  @override
  Future<void> changeLanguage(String code) async =>
      await localDataSources.changeLanguage(code);

  @override
  String? getCachedLanguage() => localDataSources.getCachedLanguage();

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
  Future<Either<Failure, List<TalonEntity>>> getUserTalons() async {
    return await _getUserTalons(() => remoteDataSource.getUserTalons());
  }

  @override
  Future<String?> getTokenFromCache() async =>
      localDataSources.getTokenFromCache();

  @override
  Future<void> setTokenToCache(String token) async =>
      localDataSources.setTokenToCache(token);

  @override
  Future<void> removeTalonFromServer(TalonEntity talon,
          {required String msg}) async =>
      await remoteDataSource.removeTalonFromServer(talon, msg: msg);

  @override
  Future<UserEntity?> getUserInforFromCache() async =>
      remoteDataSource.getUserInforFromCache();
}

// FUNCTIONS
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

Future<Either<Failure, TalonEntity>> _createTalon(
    Future<TalonEntity> Function() createTalon) async {
  try {
    final talons = await createTalon();
    return Right(talons);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<TalonEntity>>> _getUserTalons(
    Future<List<TalonEntity>> Function() getUserTalon) async {
  try {
    final talons = await getUserTalon();
    return Right(talons);
  } on ServerExeption {
    return Left(ServerFailure());
  }
}
