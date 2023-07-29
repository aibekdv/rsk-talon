import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class RemoveTalonFromServerUseCase {
  final MainRepository repository;

  RemoveTalonFromServerUseCase({required this.repository});

  Future<void> call(TalonEntity talon, {required String msg}) async {
    return repository.removeTalonFromServer(talon, msg: msg);
  }
}
