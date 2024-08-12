import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/common/domain/repository/cart_repository.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';

final class RemoveFromCartUsecase implements UseCase<SuccessEntity, String> {
  final CartRepository _cartRepository;

  const RemoveFromCartUsecase({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(String param) async {
    return await _cartRepository.removeFromCart(cartItemId: param);
  }
}
