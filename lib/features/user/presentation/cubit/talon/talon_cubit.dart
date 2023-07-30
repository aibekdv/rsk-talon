import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/domain/usecases/usecases.dart';
import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/domain/usecases/usecases.dart';

part 'talon_state.dart';

final class TalonCubit extends Cubit<TalonState> {
  final GetServicesUseCase getServicesUseCase;
  final CreateTalonUseCase createTalonUseCase;
  final SendReviewToServerUseCase sendReviewToServerUseCase;
  final GetUserTalonUseCase getUserTalonUseCase;
  final GetTokenFromCacheUseCase getTokenFromCacheUseCase;
  final TokenToCacheUseCase tokenToCacheUseCase;
  final RemoveTalonFromServerUseCase removeTalonFromServerUseCase;
  final GetUserFromCacheUseCase getUserFromCacheUseCase;

  TalonCubit({
    required this.getServicesUseCase,
    required this.createTalonUseCase,
    required this.sendReviewToServerUseCase,
    required this.getUserTalonUseCase,
    required this.getTokenFromCacheUseCase,
    required this.tokenToCacheUseCase,
    required this.removeTalonFromServerUseCase,
    required this.getUserFromCacheUseCase,
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

  createNewTalon(TalonEntity talon) async {
    emit(TalonFromCacheLoading());
    final brancheList = await createTalonUseCase(talon);
    brancheList.fold(
      (error) => emit(TalonFailure(_mapFailureToMessage(error))),
      (result) {
        emit(const TalonFromCacheSuccess(talonList: []));
      },
    );
  }

  getTalonsFromServer() async {
    if (state is! TalonFromServerSuccess) {
      emit(TalonFromServerLoading());
    }
    try {
      final brancheList = await getUserTalonUseCase();
      brancheList.fold(
        (error) => emit(TalonFailure(_mapFailureToMessage(error))),
        (result) => emit(TalonFromServerSuccess(talonList: result)),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  sendReviewToServer({
    required TalonEntity talon,
    required int rating,
    required String successMsg,
  }) async {
    emit(ReviewLoading());
    try {
      await sendReviewToServerUseCase(
        rating: rating,
        succesMsg: successMsg,
        talon: talon,
      );
      final talonCache = await getTokenFromCache();
      final talonItem = TalonModel.fromJson(
        jsonDecode(talonCache!),
      );
      emit(ReviewSucces(talon: talonItem));
      Future.delayed(const Duration(seconds: 2), () async {
        await removeTalonFromServerUseCase(talonItem, msg: '');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getTokenFromCache() async {
    return await getTokenFromCacheUseCase();
  }

  setTokenToCache(TalonEntity talon) async {
    await tokenToCacheUseCase(talon);
  }

  removeTalon(TalonEntity talon, {required String msg}) async {
    try {
      await removeTalonFromServerUseCase(talon, msg: msg);
      await getTalonsFromServer();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getUserInfo() async {
    emit(UserFromCacheLoading());
    try {
      final user = await getUserFromCacheUseCase();
      if (user != null) {
        emit(UserFromCacheLoaded(user: user));
      }
    } catch (e) {
      emit(UserFromCacheFailure());
    }
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
