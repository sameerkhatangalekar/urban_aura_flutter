import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/features/orders/data/model/order_model.dart';

abstract interface class OrderDataSource {
  Future<List<OrderModel>> getOrdersByUser();

  Future<OrderModel> getOrderById({required String orderId});

  Future<SuccessModel> cancelOrderById({required String orderId});
}