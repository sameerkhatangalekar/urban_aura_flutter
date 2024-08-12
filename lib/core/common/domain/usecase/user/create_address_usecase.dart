// ignore_for_file: non_constant_identifier_names

import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';

final class CreateAddressParams {
  final String name;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String line_one;
  final String postal_code;

  const CreateAddressParams(
      {required this.name,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.line_one,
      required this.postal_code});
}

final class CreateAddressUsecase
    implements UseCase<SuccessEntity, CreateAddressParams> {
  final UserRepository _userRepository;

  const CreateAddressUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(CreateAddressParams param) async {
    return await _userRepository.createAddress(
        name: param.name,
        city: param.city,
        state: param.state,
        country: param.country,
        contact: param.contact,
        line_one: param.line_one,
        postal_code: param.postal_code);
  }
}
