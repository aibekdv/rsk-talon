import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/usecases/usecases.dart';

part 'branch_state.dart';

final class BranchCubit extends Cubit<BranchState> {
  final GetAllBranches getAllBranches;
  final DownloadFileFromApi downloadFileFromApi;

  BranchCubit({
    required this.getAllBranches,
    required this.downloadFileFromApi,
  }) : super(BranchInitial());

  loadBranches() async {
    emit(BranchLoading());
    final brancheList = await getAllBranches(NoParams());
    brancheList.fold(
      (error) => emit(BranchFailure(_mapFailureToMessage(error))),
      (result) => emit(BranchSuccess(result)),
    );
  }

  downloadFile(List<String> url, String successMsg) async {
    emit(DownloadFileLoading());
    await downloadFileFromApi(url, successMsg);
    emit(DownloadFileSuccess());
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server failure";
      case CasheFailure:
        return "Cashe failure";
      default:
        return "Unexpected error";
    }
  }
}
