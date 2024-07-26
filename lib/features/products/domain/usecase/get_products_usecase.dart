import 'package:fpdart/fpdart.dart';
import 'package:urban_aura_flutter/core/error/failure.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';
import 'package:urban_aura_flutter/features/products/domain/repository/products_repository.dart';

final class GetProductsUsecase
    implements UseCase<List<ProductEntity>, NoParams> {
  final ProductsRepository _productsRepository;

  const GetProductsUsecase({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams param) async {
    return await _productsRepository.getAllProducts();
  }

}