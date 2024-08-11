import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';
import 'package:urban_aura_flutter/features/orders/data/datasource/order_data_source.dart';
import 'package:urban_aura_flutter/features/orders/data/model/order_model.dart';

final class OrderDataSourceImpl implements OrderDataSource {
  final Dio _dio;

  OrderDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SuccessModel> cancelOrderById({required String orderId}) async {
    try {
      final result = await _dio.put('$ordersUrl/cancel/$orderId');
      return SuccessModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<OrderModel> getOrderById({required String orderId}) async {
    try {
      final result = await _dio.get('$ordersUrl/$orderId');
      return OrderModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<List<OrderModel>> getOrdersByUser() async {
    try {
      final result = await _dio.get(ordersUrl);
      return List.from(result.data.map((order) => OrderModel.fromJson(order)));
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }
}
