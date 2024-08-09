// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/user/user_data_source.dart';
import 'package:urban_aura_flutter/core/common/data/models/address_model.dart';

class UserDataSourceImpl implements UserDataSource {
  final Dio _dio;

  const UserDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SuccessModel> createAddress(
      {required String name,
      required String city,
      required String state,
      required String country,
      required String contact,
      required String line_one,
      required String postal_code}) async {
    try {
      final result = await _dio.post('$userUrl/address/', data: {
        'name': name,
        'city': city,
        'state': state,
        'country': country,
        'contact': contact,
        'line_one': line_one,
        'postal_code': postal_code
      });

      return SuccessModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<SuccessModel> deleteAddressById({required String addressId}) async {
    try {
      final result = await _dio.delete('$userUrl/address/$addressId');

      return SuccessModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<List<AddressModel>> getAddressByUser() async {
    try {
      final result = await _dio.get('$userUrl/address');

      return List<AddressModel>.from(
        result.data.map(
          (x) => AddressModel.fromJson(x),
        ),
      );
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<SuccessModel> updateAddress(
      {required String addressId,
     required String  name,
     required String  city,
     required String  state,
     required String  country,
     required String  contact,
     required String  line_one,
     required String  postal_code}) async {
    try {

      final result = await _dio.put('$userUrl/address/$addressId', data: {
        'name': name,
        'city': city,
        'state': state,
        'country': country,
        'contact': contact,
        'line_one': line_one,
        'postal_code': postal_code
      });

      return SuccessModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }
}
