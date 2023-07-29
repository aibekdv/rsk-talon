import 'package:rsk_talon/features/user/domain/repositories/main_repository.dart';

final class GetUserTalonUseCase {
  final MainRepository repository;

  GetUserTalonUseCase({required this.repository});

  call() {
    return repository.getUserTalons();
  }
}
