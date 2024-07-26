import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/helper/error_processor.dart';
import 'package:urban_aura_flutter/features/products/data/model/product_model.dart';

import 'products_remote_data_source.dart';

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio _dio;

  const ProductsRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get(productUrl);
      return parseProductList(
        jsonEncode(response.data),
      );
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }

  @override
  Future<ProductModel> getProductById({required String productId}) async {
    try {
      final response = await _dio.get('$productUrl/$productId');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(dioErrorProcessor(e));
    }
  }
}
