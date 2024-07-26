import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/exceptions.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/features/products/data/datasource/products_remote_data_source.dart';

import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

import '../../domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _productsRemoteDataSource;

  const ProductsRepositoryImpl({
    required ProductsRemoteDataSource productsRemoteDataSource,
  }) : _productsRemoteDataSource = productsRemoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final response = await _productsRemoteDataSource.getAllProducts();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(
      {required String productId}) async {
    try {
      final response = await _productsRemoteDataSource.getProductById(
        productId: productId,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
