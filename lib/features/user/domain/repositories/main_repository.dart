import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';

abstract class MainRepository {
  Future<Either<Failure, List<BranchEntity>>> getAllBranches();
  Future<Either<Failure, List<ServiceEntity>>> getAllServices();
  Future<Either<Failure, List<TalonEntity>>> getAllTalons();
  Future<Either<Failure, TalonEntity>> createTalon(TalonEntity talon);
  Future<List<TalonEntity>> getCachedTalons();
  String? getCachedLanguage();
  Future<void> changeLanguage(String code);
  Future<void> deleteTalonFromCache(TalonEntity talon);
  void talonToCache(TalonEntity talon);
  Future<void> setTokenToCache(String token);
  Future<String?> getTokenFromCache();
  Future<void> sendReviewToServer({
    required String token,
    required int rating,
    required String succesMsg,
  });
}
