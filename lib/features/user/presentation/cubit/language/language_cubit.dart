import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/features/user/domain/usecases/usecases.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final ChangeLangUseCase changeLangUseCase;
  final GetCachedLangUseCase getCachedLangUseCase;

  LanguageCubit({
    required this.changeLangUseCase,
    required this.getCachedLangUseCase,
  }) : super(LanguageInitial());

  changeLanguage(String code) async {
    emit(ChangeLanguageLoading());
    await changeLangUseCase(code);
    getCachedLanguage();
  }

  getCachedLanguage() async {
    emit(ChangeLanguageLoading());
    final code = getCachedLangUseCase();
    if (code != null) {
      emit(ChangeLanguage(locale: Locale(code)));
    }
  }
}
