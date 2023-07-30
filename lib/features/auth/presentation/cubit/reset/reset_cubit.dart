import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/usecases/usecases.dart';

part 'reset_state.dart';

class ResetCubit extends Cubit<ResetState> {
  final RestorePasswordUseCase restorePasswordUseCase;
  final SetRestorePasswordUseCase setRestorePasswordUseCase;

  ResetCubit({
    required this.restorePasswordUseCase,
    required this.setRestorePasswordUseCase,
  }) : super(ResetInitial());

  sendCodeToPhone({required String phone}) async {
    emit(ResetPhoneLoading());
    try {
      await restorePasswordUseCase(phone);
      emit(ResetPhoneLoaded());
    } catch (e) {
      emit(ResetPhoneFailure());
    }
  }

  setRestorePassword({
    required UserEntity user,
    required String successMsg,
    required String code,
  }) async {
    emit(ResetPasswordLoading());
    try {
      await setRestorePasswordUseCase(
        phone: user.phoneNumber!,
        password: user.password!,
        confirmPassword: user.confirmPassword!,
        code: code,
        successMsg: successMsg,
      );
      emit(ResetPasswordLoaded());
    } catch (e) {
      emit(ResetPasswordFailure());
    }
  }
}
