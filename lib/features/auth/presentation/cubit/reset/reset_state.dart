part of 'reset_cubit.dart';

abstract class ResetState extends Equatable {
  const ResetState();

  @override
  List<Object> get props => [];
}

class ResetInitial extends ResetState {}

class ResetPhoneLoading extends ResetState {}

class ResetPhoneLoaded extends ResetState {}

class ResetPhoneFailure extends ResetState {}

class ResetPasswordLoading extends ResetState {}

class ResetPasswordLoaded extends ResetState {}

class ResetPasswordFailure extends ResetState {}
