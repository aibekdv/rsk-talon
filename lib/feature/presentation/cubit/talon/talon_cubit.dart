import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/core/core.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/domain/usecases/usecases.dart';

part 'talon_state.dart';

class TalonCubit extends Cubit<TalonState> {
  final GetServicesUseCase getServicesUseCase;
  final GetTalonsUseCase getTalonsUseCase;
  final CreateTalonUseCase createTalonUseCase;
  final GetCachedTalonsUseCase getCachedTalonsUseCase;
  final TalonToCacheUseCase talonToCacheUseCase;

  TalonCubit({
    required this.getServicesUseCase,
    required this.getTalonsUseCase,
    required this.createTalonUseCase,
    required this.getCachedTalonsUseCase,
    required this.talonToCacheUseCase,
  }) : super(TalonInitial());

  fetchServicesFromServer() async {
    emit(ServiceLoading());
    final brancheList = await getServicesUseCase(NoParams());
    brancheList.fold(
      (error) => emit(ServiceFailure(_mapFailureToMessage(error))),
      (result) => emit(ServiceSuccess(serviceList: result)),
    );
  }

  getTalonsFromServer() async {
    emit(TalonCacheLoading());
    final brancheList = await getTalonsUseCase(NoParams());
    brancheList.fold(
      (error) => emit(TalonCacheFailure(_mapFailureToMessage(error))),
      (result) => emit(TalonCacheSuccess(talonList: result)),
    );
  }

  createNewTalon(TalonEntity talon) async {
    emit(TalonLoading());
    final brancheList = await createTalonUseCase(talon);
    brancheList.fold(
      (error) => emit(TalonFailure(_mapFailureToMessage(error))),
      (result) {
        talonToCacheUseCase(result);
        emit(const TalonSuccess(talonList: []));
      },
    );
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
