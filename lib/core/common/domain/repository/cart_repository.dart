
import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/cart_entity.dart';

abstract interface class CartRepository {
  Future<Either<Failure,CartEntity>> getCart();


  Future<Either<Failure,SuccessEntity>>incrementItemCount({
    required String cartItemId,
    required int quantity,
  });

  Future<Either<Failure,SuccessEntity>>decrementItemCount({
    required String cartItemId,
    required int quantity,
  });


  Future<Either<Failure,SuccessEntity>>addToCart({
    required String productId,
    required int quantity,
    required String color,
    required String size
  });



}