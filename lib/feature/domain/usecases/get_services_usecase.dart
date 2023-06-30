import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/error/failure.dart';
import 'package:rsk_talon/core/usecase/usecase.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

class GetServicesUseCase extends UseCase<List<ServiceEntity>, NoParams> {
  final MainRepository repository;

  GetServicesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ServiceEntity>>> call(NoParams params)async =>
     await repository.getAllServices();
}
