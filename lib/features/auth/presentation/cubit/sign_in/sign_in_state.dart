part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {}

class SignInFailure extends SignInState {}

class GetUserTokenLoading extends SignInState {}

class GetUserTokenLoaded extends SignInState {
  final String? token;

  const GetUserTokenLoaded({this.token});
}

class GetUserTokenFailure extends SignInState {}

class GetUserCacheLoading extends SignInState {}

class GetUserCacheLoaded extends SignInState {
  final UserEntity? user;

  const GetUserCacheLoaded({this.user});
}

class GetUserCacheFailure extends SignInState {}

class RefreshTokenLoading extends SignInState {}

class RefreshTokenLoaded extends SignInState {}

class RefreshTokenFailure extends SignInState {}
