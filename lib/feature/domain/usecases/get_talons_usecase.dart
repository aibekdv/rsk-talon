import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/error/failure.dart';
import 'package:rsk_talon/core/usecase/usecase.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

final class GetTalonsUseCase extends UseCase<List<TalonEntity>, NoParams> {
  final MainRepository repository;

  GetTalonsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TalonEntity>>> call(NoParams params) async =>
      await repository.getAllTalons();
}
