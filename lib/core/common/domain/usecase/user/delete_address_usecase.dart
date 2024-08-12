import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';

final class DeleteAddressUsecase implements UseCase<SuccessEntity, String> {
  final UserRepository _userRepository;

  const DeleteAddressUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(String param) async {
    return await _userRepository.deleteAddressById(addressId: param);
  }
}
