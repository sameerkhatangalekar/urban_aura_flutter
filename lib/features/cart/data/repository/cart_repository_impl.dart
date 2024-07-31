import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/cart/data/datasources/cart_remote_datasource.dart';

import 'package:urban_aura_flutter/features/cart/domain/entity/cart_entity.dart';

import '../../domain/repository/cart_repository.dart';

final class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource _cartRemoteDatasource;

  const CartRepositoryImpl({required CartRemoteDatasource cartRemoteDatasource})
      : _cartRemoteDatasource = cartRemoteDatasource;

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final result = await _cartRemoteDatasource.getCart();
      return right(result);
    } on ServerException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, SuccessEntity>> decrementItemCount({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      final result = await _cartRemoteDatasource.decrementItemCount(
          id: cartItemId, quantity: quantity);
      return right(result);
    } on ServerException catch (error) {
      return left(
        Failure(
          error.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SuccessEntity>> incrementItemCount({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      final result = await _cartRemoteDatasource.incrementItemCount(
          id: cartItemId, quantity: quantity);
      return right(result);
    } on ServerException catch (error) {
      return left(
        Failure(
          error.message,
        ),
      );
    }
  }
}
