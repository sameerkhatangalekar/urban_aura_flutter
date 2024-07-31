import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/cart/domain/entity/cart_entity.dart';
import 'package:urban_aura_flutter/features/cart/domain/repository/cart_repository.dart';

final class GetCartUsecase implements UseCase<CartEntity, NoParams> {
  final CartRepository _cartRepository;

  const GetCartUsecase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, CartEntity>> call(NoParams param) async {
    return await _cartRepository.getCart();
  }
}
