import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());
}
