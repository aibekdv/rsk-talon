part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

final class ChangeLanguageLoading extends LanguageState {}

final class ChangeLanguage extends LanguageState {
  final Locale locale;

  const ChangeLanguage({required this.locale});
}
