import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';
import 'package:urban_aura_flutter/features/orders/domain/repository/order_repository.dart';

final class GetOrdersByUserUsecase
    implements UseCase<List<OrderEntity>, NoParams> {
  final OrderRepository _orderRepository;

  GetOrdersByUserUsecase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(NoParams param) async {
    return await _orderRepository.getOrdersByUser();
  }
}
