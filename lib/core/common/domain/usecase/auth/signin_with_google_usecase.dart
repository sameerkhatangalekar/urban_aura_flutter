import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import '../../repository/auth_repository.dart';

final class SigninWithGoogleUsecase implements UseCase<String,NoParams> {
  final AuthRepository _authRepository;

  const SigninWithGoogleUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;


  @override
  Future<Either<Failure, String>> call(NoParams param)  async {
    return await _authRepository.signInWithGoogle();
  }
}
