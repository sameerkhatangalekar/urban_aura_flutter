import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';

abstract interface class UseCase<Success, Params> {
  Future<Either<Failure, Success>> call(Params param);
}

final class NoParams{
  const NoParams();
}