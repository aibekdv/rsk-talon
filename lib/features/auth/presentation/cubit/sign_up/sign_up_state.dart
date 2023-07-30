part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {}

class SignUpFailure extends SignUpState {}

class ActivateAccountLoading extends SignUpState {}

class ActivateAccountLoaded extends SignUpState {}

class ActivateAccountFailure extends SignUpState {}
