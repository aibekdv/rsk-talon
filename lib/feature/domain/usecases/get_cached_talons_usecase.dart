import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

class GetCachedTalonsUseCase {
  final MainRepository repository;

  GetCachedTalonsUseCase({required this.repository});

  Future<List<TalonEntity>> call() async {
    return await repository.getCachedTalons();
  }
}
