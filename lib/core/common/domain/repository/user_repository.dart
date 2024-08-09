// ignore_for_file: non_constant_identifier_names

import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddressByUser();

  Future<Either<Failure, SuccessEntity>> createAddress({
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<Either<Failure, SuccessEntity>> updateAddress({
    required String addressId,
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<Either<Failure, SuccessEntity>> deleteAddressById({
    required String addressId,
  });
}
