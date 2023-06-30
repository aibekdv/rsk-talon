part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class ChangeLanguage extends LanguageState {
  final Locale locale;

  const ChangeLanguage({required this.locale});
}
