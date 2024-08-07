import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class ProductsRepository {

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, ProductEntity>> getProductById({
    required String productId,
  });

}
