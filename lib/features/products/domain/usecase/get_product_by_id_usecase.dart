import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase.dart';
import '../../../../core/common/domain/entities/product_entity.dart';
import '../repository/products_repository.dart';

final class GetProductsByIdUsecase
    implements UseCase<ProductEntity, String> {
  final ProductsRepository _productsRepository;

  const GetProductsByIdUsecase({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository;

  @override
  Future<Either<Failure, ProductEntity>> call(String param) async {
    return await _productsRepository.getProductById(productId: param);
  }

}