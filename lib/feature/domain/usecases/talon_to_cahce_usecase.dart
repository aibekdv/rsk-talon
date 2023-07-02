import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/repositories/main_repository.dart';

final class TalonToCacheUseCase {
  final MainRepository repository;

  TalonToCacheUseCase({required this.repository});

  void call(TalonEntity talon) async {
    return repository.talonToCache(talon);
  }
}
