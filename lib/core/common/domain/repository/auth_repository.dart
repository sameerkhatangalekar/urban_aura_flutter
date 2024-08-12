import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signin(
      {required String email, required String password});

  Future<Either<Failure, String>> signup(
      {required String email, required String name, required String password});

  Future<Either<Failure, String>> signInWithGoogle();

  // Future<Either<Failure, String>> signUpWithGoogle();

  Future<Either<Failure, void>> signOut();

  Stream<bool> get userState;
}
