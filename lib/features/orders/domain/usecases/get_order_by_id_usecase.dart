import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';
import 'package:urban_aura_flutter/features/orders/domain/repository/order_repository.dart';

final class GetOrderByIdUsecase implements UseCase<OrderEntity, String> {
  final OrderRepository _orderRepository;

  GetOrderByIdUsecase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, OrderEntity>> call(String param) async {
    return await _orderRepository.getOrderById(orderId: param);
  }
}
