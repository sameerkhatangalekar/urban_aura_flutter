import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/repository/order_repository.dart';

final class CancelOrderByIdUsecase implements UseCase<SuccessEntity, String> {
  final OrderRepository _orderRepository;

  CancelOrderByIdUsecase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, SuccessEntity>> call(String param) async {
    return await _orderRepository.cancelOrderById(orderId: param);
  }
}
