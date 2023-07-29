import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/usecases/usecases.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final GetAuthTokenFromCache getAuthTokenFromCache;
  final GetUserFromCacheUseCase getUserFromCacheUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;

  SignInCubit({
    required this.getUserFromCacheUseCase,
    required this.getAuthTokenFromCache,
    required this.signInUseCase,
    required this.logoutUseCase,
    required this.refreshTokenUseCase,
  }) : super(SignInInitial());

  login(UserEntity user) async {
    emit(SignInLoading());
    try {
      await signInUseCase(user);
      emit(SignInLoaded());
    } catch (e) {
      emit(SignInFailure());
    }
  }

  String? getUserToken() => getAuthTokenFromCache();

  getUserFromCache() async {
    emit(GetUserCacheLoading());
    try {
      UserEntity? user = await getUserFromCacheUseCase();
      emit(GetUserCacheLoaded(user: user));
    } catch (e) {
      emit(GetUserCacheFailure());
    }
  }

  refreshToken() async {
    emit(RefreshTokenLoading());
    try {
      await refreshTokenUseCase();

      // Get a new token every 19 minutes
      Timer.periodic(const Duration(minutes: 19), (timer) async {
        await refreshTokenUseCase();
        emit(RefreshTokenLoaded());
      });

      emit(RefreshTokenLoaded());
    } catch (e) {
      await logout();
      emit(RefreshTokenFailure());
    }
  }

  logout() async {
    await logoutUseCase();
    emit(SignInInitial());
  }
}
