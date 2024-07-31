
import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/cart/domain/repository/cart_repository.dart';

final class IncrementCartItemCountParams {
  final String cartItemId;
  final int quantity;

  const IncrementCartItemCountParams(
      {required this.cartItemId, required this.quantity});
}

class IncrementCartItemCountUsecase implements UseCase<SuccessEntity, IncrementCartItemCountParams> {
  final CartRepository _cartRepository;
  const IncrementCartItemCountUsecase({required CartRepository cartRepository}) : _cartRepository = cartRepository;
  @override
  Future<Either<Failure, SuccessEntity>> call(IncrementCartItemCountParams param)  async{
    return await _cartRepository.incrementItemCount(cartItemId: param.cartItemId, quantity: param.quantity);
  }
}
