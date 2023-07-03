import 'package:rsk_talon/feature/domain/repositories/repositories.dart';

class DownloadFileFromApi {
  final MainRepository repository;

  DownloadFileFromApi({required this.repository});

  Future<void> call(List<String> url, String serviceType) async {
    return await repository.downloadFileFromApi(url, serviceType);
  }
}
