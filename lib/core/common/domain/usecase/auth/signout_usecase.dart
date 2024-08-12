import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/auth_repository.dart';

final class SignOutUsecase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams param) async {
    return await _authRepository.signOut();
  }
}
