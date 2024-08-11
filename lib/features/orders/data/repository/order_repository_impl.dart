import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/success_entity.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/orders/data/datasource/order_data_source.dart';
import 'package:urban_aura_flutter/features/orders/domain/entity/order_entity.dart';
import 'package:urban_aura_flutter/features/orders/domain/repository/order_repository.dart';

final class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRepositoryImpl({required OrderDataSource orderDataSource})
      : _orderDataSource = orderDataSource;

  @override
  Future<Either<Failure, SuccessEntity>> cancelOrderById(
      {required String orderId}) async {
    try {
      final result = await _orderDataSource.cancelOrderById(orderId: orderId);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(
      {required String orderId}) async {
    try {
      final result = await _orderDataSource.getOrderById(orderId: orderId);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrdersByUser() async {
    try {
      final result = await _orderDataSource.getOrdersByUser();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
