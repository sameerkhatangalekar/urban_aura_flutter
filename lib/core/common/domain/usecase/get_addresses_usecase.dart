import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';

final class GetAddressesUsecase
    implements UseCase<List<AddressEntity>, NoParams> {
  final UserRepository _userRepository;

  const GetAddressesUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, List<AddressEntity>>> call(NoParams param) async {
    return await _userRepository.getAddressByUser();
  }
}
