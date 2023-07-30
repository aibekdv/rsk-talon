import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/usecases/usecases.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  final ActivateAccountUseCase activateAccountUseCase;

  SignUpCubit({
    required this.signUpUseCase,
    required this.activateAccountUseCase,
  }) : super(SignUpInitial());

  register({required UserEntity user, required String successMsg}) async {
    emit(SignUpLoading());
    try {
      await signUpUseCase(user: user, successMsg: successMsg);
      emit(SignUpLoaded());
    } catch (e) {
      emit(SignUpFailure());
    }
  }

  activateAccount({
    required String phone,
    required String code,
    required String successMsg,
  }) async {
    emit(ActivateAccountLoading());
    try {
      await activateAccountUseCase(
        code: code,
        phone: phone,
        successMsg: successMsg,
      );
      emit(ActivateAccountLoaded());
    } catch (e) {
      emit(ActivateAccountFailure());
    }
  }
}
