import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';

abstract class MainRepository {
  Future<Either<Failure, List<BranchEntity>>> getAllBranches();
  Future<Either<Failure, List<ServiceEntity>>> getAllServices();
  Future<Either<Failure, List<TalonEntity>>> getUserTalons();
  Future<Either<Failure, TalonEntity>> createTalon(TalonEntity talon);
  Future<void> setTokenToCache(TalonEntity talon);
  Future<void> removeTalonFromServer(TalonEntity talon,{required String msg});
  Future<String?> getTokenFromCache();
  Future<UserEntity?> getUserInforFromCache();

  String? getCachedLanguage();
  Future<void> changeLanguage(String code);
  Future<void> sendReviewToServer({
    required TalonEntity talon,
    required int rating,
    required String succesMsg,
  });
}
