import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class SendReviewToServerUseCase {
  final MainRepository repository;

  SendReviewToServerUseCase({required this.repository});

  Future<void> call({
    required TalonEntity talon,
    required int rating,
    required String succesMsg,
  }) async {
    return repository.sendReviewToServer(
      talon: talon,
      rating: rating,
      succesMsg: succesMsg,
    );
  }
}
