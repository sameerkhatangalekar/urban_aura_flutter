import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';

import 'package:urban_aura_flutter/features/auth/domain/repository/auth_repository.dart';

class SignupUsecase implements UseCase<String, SignUpParams> {
  final AuthRepository _authRepository;

  const SignupUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> call(SignUpParams param) async {
    return await _authRepository.signup(
        email: param.email, name: param.name, password: param.password);
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  const SignUpParams(
      {required this.email, required this.name, required this.password});
}
