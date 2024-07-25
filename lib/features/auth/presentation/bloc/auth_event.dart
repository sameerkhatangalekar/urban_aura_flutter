part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}


final class SigninEvent extends AuthEvent {
  final String email;
  final String password;

  const SigninEvent({required this.email,required this.password});

  @override
  List<Object?> get props => [email,password];

}

final class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignupEvent({required this.email,required this.name,required this.password});

  @override
  List<Object?> get props => [name,email,password];

}

