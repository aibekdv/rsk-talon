import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/error/failure.dart';
import 'package:rsk_talon/core/usecase/usecase.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

class CreateTalonUseCase extends UseCase<TalonEntity, TalonEntity> {
  final MainRepository repository;

  CreateTalonUseCase({required this.repository});

  @override
  Future<Either<Failure, TalonEntity>> call(TalonEntity talon) async =>
      await repository.createTalon(talon);
}
