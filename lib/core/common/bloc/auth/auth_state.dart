part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

final class LoadingState extends AuthState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

final class SignupFailedState extends AuthState {
  final String message;
  const SignupFailedState({required this.message});

  @override
  List<Object> get props => [message];
}


final class SigninSuccessfulState extends AuthState {
  const SigninSuccessfulState();

  @override
  List<Object> get props => [];
}


final class SigninFailedState extends AuthState {
  final String message;
  const SigninFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

final class SignOutFailedState extends AuthState {
  final String message;
  const SignOutFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

final class SignedOutState extends AuthState {
  const SignedOutState();

  @override
  List<Object> get props => [];
}

