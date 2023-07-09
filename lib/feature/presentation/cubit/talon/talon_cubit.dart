import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/usecases/usecases.dart';

part 'talon_state.dart';

final class TalonCubit extends Cubit<TalonState> {
  final GetServicesUseCase getServicesUseCase;
  final GetTalonsUseCase getTalonsUseCase;
  final CreateTalonUseCase createTalonUseCase;
  final GetCachedTalonsUseCase getCachedTalonsUseCase;
  final TalonToCacheUseCase talonToCacheUseCase;
  final DeleteTalonFromCacheUseCase deleteTalonFromCacheUseCase;
  final TokenToCacheUseCase setTokenToCacheUseCase;
  final GetTokenFromCacheUseCase getTokenFromCacheUseCase;
  final SendReviewToServerUseCase sendReviewToServerUseCase;

  TalonCubit({
    required this.getServicesUseCase,
    required this.getTalonsUseCase,
    required this.createTalonUseCase,
    required this.getCachedTalonsUseCase,
    required this.talonToCacheUseCase,
    required this.deleteTalonFromCacheUseCase,
    required this.setTokenToCacheUseCase,
    required this.getTokenFromCacheUseCase,
    required this.sendReviewToServerUseCase,
  }) : super(TalonInitial());

  fetchServicesFromServer() async {
    emit(ServiceLoading());
    try {
      final brancheList = await getServicesUseCase(NoParams());
      brancheList.fold(
        (error) => emit(ServiceFailure(_mapFailureToMessage(error))),
        (result) => emit(ServiceSuccess(serviceList: result)),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getTalonsFromServer() async {
    if (state is! TalonFromServerSuccess) {
      emit(TalonFromServerLoading());
    }

    try {
      final brancheList = await getTalonsUseCase(NoParams());
      brancheList.fold(
        (error) => emit(TalonFailure(_mapFailureToMessage(error))),
        (result) => emit(TalonFromServerSuccess(talonList: result)),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  createNewTalon(TalonEntity talon) async {
    emit(TalonFromCacheLoading());
    try {
      final brancheList = await createTalonUseCase(talon);
      brancheList.fold(
        (error) => emit(TalonFailure(_mapFailureToMessage(error))),
        (result) {
          talonToCacheUseCase(result);
          emit(const TalonFromCacheSuccess(talonList: []));
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getCachedTalons() async {
    emit(TalonCacheLoading());
    try {
      final talons = await getCachedTalonsUseCase();
      emit(TalonCacheSuccess(talonList: talons));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteTalonItem(TalonEntity talon) async {
    emit(TalonCacheLoading());

    try {
      deleteTalonFromCacheUseCase(talon);
      final talonList = await getCachedTalonsUseCase();
      emit(TalonCacheSuccess(talonList: talonList));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  sendReviewToServer({
    required String token,
    required int rating,
    required String successMsg,
  }) async {
    emit(ReviewLoading());
    try {
      await sendReviewToServerUseCase(
        rating: rating,
        succesMsg: successMsg,
        token: token,
      );
      emit(ReviewSucces(token: await getTokenFromCache()));
    } catch (e) {
      toast(msg:e.toString(),isError: true);
    }
  }

  Future<String?> getTokenFromCache() async {
    return await getTokenFromCacheUseCase();
  }

  setTokenToCache(String token) async {
    await setTokenToCacheUseCase(token);
  }
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
