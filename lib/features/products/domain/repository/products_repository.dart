import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class ProductsRepository {

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, ProductEntity>> getProductById({
    required String productId,
  });

}
