import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';

part 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<String> signin(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(signInUrl, data: {
        "email": email,
        "password": password,
      });
      return response.data['accessToken'];
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<String> signup(
      {required String email,
      required String name,
      required String password}) async {
    try {
      await _dio.post(signUpUrl, data: {
        "email": email,
        "password": password,
        "name": name,
      });
      return 'Signup completed';
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError('Logout functionality is not implemented');
  }
}
