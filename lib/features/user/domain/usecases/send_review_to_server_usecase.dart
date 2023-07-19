import 'package:rsk_talon/features/user/domain/repositories/repositories.dart';

class SendReviewToServerUseCase {
  final MainRepository repository;

  SendReviewToServerUseCase({required this.repository});

  Future<void> call({
    required String token,
    required int rating,
    required String succesMsg,
  }) async {
    return repository.sendReviewToServer(
      token: token,
      rating: rating,
      succesMsg: succesMsg,
    );
  }
}
