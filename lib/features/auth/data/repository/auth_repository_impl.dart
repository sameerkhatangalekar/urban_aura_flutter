import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:urban_aura_flutter/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, String>> signin(
      {required String email, required String password}) async {
    try {
      final result =
          await _authRemoteDataSource.signin(email: email, password: password);
      return right(result);
    } on ServerException catch (error) {
      return left(error.message.isEmpty ? Failure() : Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, String>> signup(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final result = await _authRemoteDataSource.signup(
          email: email, password: password, name: name);
      return right(result);
    } on ServerException catch (error) {
      return left(error.message.isEmpty ? Failure() : Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
