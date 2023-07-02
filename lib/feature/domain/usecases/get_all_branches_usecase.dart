import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/error/failure.dart';
import 'package:rsk_talon/core/usecase/usecase.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

final class GetAllBranches extends UseCase<List<BranchEntity>, NoParams> {
  final MainRepository repository;

  GetAllBranches({required this.repository});

  @override
  Future<Either<Failure, List<BranchEntity>>> call(NoParams params)async =>
     await repository.getAllBranches();
}
