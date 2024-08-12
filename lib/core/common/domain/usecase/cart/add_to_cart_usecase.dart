import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/cart_repository.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';

final class AddToCartParams {
  final String productId;
  final int quantity;
  final String color;
  final String size;

  const AddToCartParams(
      {required this.productId,
      this.quantity = 1,
      required this.color,
      required this.size});
}

class AddToCartUsecase implements UseCase<SuccessEntity, AddToCartParams> {
  final CartRepository _cartRepository;

  const AddToCartUsecase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(AddToCartParams param) async {
    return await _cartRepository.addToCart(
      productId: param.productId,
      quantity: param.quantity,
      color: param.color,
      size: param.size,
    );
  }
}
