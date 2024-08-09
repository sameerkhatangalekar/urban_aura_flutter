import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/common/data/models/success_model.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';
import 'package:urban_aura_flutter/core/common/data/datasources/cart/cart_remote_datasource.dart';
import 'package:urban_aura_flutter/core/common/data/models/cart_model.dart';

class CartRemoteDatasourceImpl implements CartRemoteDatasource {
  final Dio _dio;

  const CartRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<CartModel> getCart() async {
    try {
      final response = await _dio.get(cartUrl);

      return CartModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<SuccessModel> incrementItemCount({
    required String id,
    required int quantity,
  }) async {
    try {
      final response = await _dio.put(incrementCartItemCountUrl,data: {
        "id" : id,
        "quantity" : quantity
      });
      return SuccessModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<SuccessModel> decrementItemCount({
    required String id,
    required int quantity,
  }) async {
    try {
      final response = await _dio.put(decrementCartItemCountUrl,data: {
        "id" : id,
        "quantity" : quantity
      });
      return SuccessModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<SuccessModel> addToCart({required String productId, required int quantity, required String size, required String color}) async {
    try {
      final response = await _dio.post(cartUrl,data: {
        "productId" : productId,
        "quantity" : quantity,
        "color" : color,
        "size" : size
      });
      return SuccessModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }

  @override
  Future<SuccessModel> removeFromCart({required String cartItemId}) async {
    try {
      final response = await _dio.delete('$cartUrl/$cartItemId');
      return SuccessModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(dioErrorProcessor(error));
    }
  }
}
