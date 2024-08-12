// ignore_for_file: non_constant_identifier_names

import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';

final class UpdateAddressParams {
  final String addressId;
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const UpdateAddressParams(
      {required this.addressId,
      required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class UpdateAddressUsecase
    implements UseCase<SuccessEntity, UpdateAddressParams> {
  final UserRepository _userRepository;

  const UpdateAddressUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(UpdateAddressParams param) async {
    return await _userRepository.updateAddress(
      addressId: param.addressId,
        name: param.name,
        city: param.city,
        state: param.state,
        country: param.country,
        contact: param.contact,
        line_one: param.line_one,
        postal_code: param.postal_code);
  }
}
