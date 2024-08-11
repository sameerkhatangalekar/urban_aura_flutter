import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrdersByUser();

  Future<Either<Failure, OrderEntity>> getOrderById({required String orderId});

  Future<Either<Failure, SuccessEntity>> cancelOrderById(
      {required String orderId});
}
