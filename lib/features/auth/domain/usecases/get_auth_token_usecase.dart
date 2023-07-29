import 'package:rsk_talon/features/auth/domain/repositories/repositories.dart';

class GetAuthTokenFromCache {
  final AuthRepository repository;

  GetAuthTokenFromCache({required this.repository});

  String? call() {
    return repository.getAuthTokenFromCache();
  }
}
