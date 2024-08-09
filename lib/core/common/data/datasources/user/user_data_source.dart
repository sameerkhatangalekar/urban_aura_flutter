// ignore_for_file: non_constant_identifier_names

import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';

import 'package:urban_aura_flutter/core/common/data/models/address_model.dart';

abstract class UserDataSource {
  Future<List<AddressModel>> getAddressByUser();

  Future<SuccessModel> createAddress({
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<SuccessModel> updateAddress({
    required String addressId,
    required String name,
    required String city,
    required String state,
    required String country,
    required String contact,
    required String line_one,
    required String postal_code,
  });

  Future<SuccessModel> deleteAddressById({
    required String addressId,
  });
}
