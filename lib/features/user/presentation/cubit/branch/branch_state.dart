part of 'branch_cubit.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

final class BranchInitial extends BranchState {}

final class BranchLoading extends BranchState {}

final class BranchFailure extends BranchState {
  final String message;

  const BranchFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class BranchSuccess extends BranchState {
  final List<BranchEntity> brancheList;

  const BranchSuccess(this.brancheList);

  @override
  List<Object> get props => [brancheList];
}

final class DownloadFileLoading extends BranchState {}

final class DownloadFileSuccess extends BranchState {}
