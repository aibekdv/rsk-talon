part of 'talon_cubit.dart';

abstract class TalonState extends Equatable {
  const TalonState();

  @override
  List<Object> get props => [];
}

class TalonInitial extends TalonState {}

class TalonLoading extends TalonState {}

class TalonFailure extends TalonState {
  final String message;

  const TalonFailure(this.message);

  @override
  List<Object> get props => [message];
}

class TalonSuccess extends TalonState {
  final List<TalonEntity> talonList;

  const TalonSuccess({required this.talonList});

  @override
  List<Object> get props => [talonList];
}

class ServiceLoading extends TalonState {}

class ServiceFailure extends TalonState {
  final String message;

  const ServiceFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ServiceSuccess extends TalonState {
  final List<ServiceEntity> serviceList;

  const ServiceSuccess({required this.serviceList});
}

class TalonCacheLoading extends TalonState {}

class TalonCacheFailure extends TalonState {
  final String message;

  const TalonCacheFailure(this.message);

  @override
  List<Object> get props => [message];
}

class TalonCacheSuccess extends TalonState {
  final List<TalonEntity> talonList;

  const TalonCacheSuccess({required this.talonList});
}
