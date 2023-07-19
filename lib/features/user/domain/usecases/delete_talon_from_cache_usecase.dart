import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/repositories/main_repository.dart';

final class DeleteTalonFromCacheUseCase {
  final MainRepository repository;

  DeleteTalonFromCacheUseCase({required this.repository});

  Future<void> call(TalonEntity talon) async =>
      await repository.deleteTalonFromCache(talon);
}
