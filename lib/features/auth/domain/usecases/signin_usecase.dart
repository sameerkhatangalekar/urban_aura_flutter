import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import '../repository/auth_repository.dart';

final class SigninUsecase implements UseCase<String, SignInParams> {
  final AuthRepository _authRepository;

  const SigninUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;


  @override
  Future<Either<Failure, String>> call(SignInParams param)  async {
    return await _authRepository.signin(email: param.email,   password: param.password);
  }
}

final class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
}
