// ignore_for_file: non_constant_identifier_names

import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/user/user_data_source.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  const UserRepositoryImpl({required UserDataSource userDataSource})
      : _userDataSource = userDataSource;

  @override
  Future<Either<Failure, SuccessEntity>> createAddress(
      {required String name,
      required String city,
      required String state,
      required String country,
      required String contact,
      required String line_one,
      required String postal_code}) async {
    try {
      final result = await _userDataSource.createAddress(
          name: name,
          city: city,
          state: state,
          country: country,
          contact: contact,
          line_one: line_one,
          postal_code: postal_code);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessEntity>> deleteAddressById(
      {required String addressId}) async {
    try {
      final result =
          await _userDataSource.deleteAddressById(addressId: addressId);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddressByUser() async {
    try {
      final result = await _userDataSource.getAddressByUser();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, SuccessEntity>> updateAddress(
      {required String addressId,
      required String name,
      required String city,
      required String state,
      required String country,
      required String contact,
      required String line_one,
      required String postal_code}) async {
    try {
      final result = await _userDataSource.updateAddress(
          addressId: addressId,
          name: name,
          city: city,
          state: state,
          country: country,
          contact: contact,
          line_one: line_one,
          postal_code: postal_code);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
