import 'package:dartz/dartz.dart';
import 'package:rsk_talon/core/error/error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
