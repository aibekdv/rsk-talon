part of 'talon_cubit.dart';

abstract class TalonState extends Equatable {
  const TalonState();

  @override
  List<Object> get props => [];
}

final class TalonInitial extends TalonState {}

final class TalonFromServerLoading extends TalonState {}

final class TalonFromCacheLoading extends TalonState {}

final class TalonFailure extends TalonState {
  final String message;

  const TalonFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class TalonFromCacheSuccess extends TalonState {
  final List<TalonEntity> talonList;

  const TalonFromCacheSuccess({required this.talonList});

  @override
  List<Object> get props => [talonList];
}

final class TalonFromServerSuccess extends TalonState {
  final List<TalonEntity> talonList;

  const TalonFromServerSuccess({required this.talonList});

  @override
  List<Object> get props => [talonList];
}

final class ServiceLoading extends TalonState {}

final class ServiceFailure extends TalonState {
  final String message;

  const ServiceFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ServiceSuccess extends TalonState {
  final List<ServiceEntity> serviceList;

  const ServiceSuccess({required this.serviceList});
}

final class TalonCacheLoading extends TalonState {}

final class TalonCacheFailure extends TalonState {
  final String message;

  const TalonCacheFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class TalonCacheSuccess extends TalonState {
  final List<TalonEntity> talonList;

  const TalonCacheSuccess({required this.talonList});
}

final class ReviewLoading extends TalonState {}

final class ReviewSucces extends TalonState {
  final TalonEntity? talon;

  const ReviewSucces({this.talon});
}

final class UserFromCacheLoading extends TalonState {}

final class UserFromCacheLoaded extends TalonState {
  final UserEntity user;

  const UserFromCacheLoaded({required this.user});
}

final class UserFromCacheFailure extends TalonState {}
