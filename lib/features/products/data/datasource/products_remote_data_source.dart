import '../../../../core/common/data/models/product_model.dart';

abstract interface class ProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();

  Future<ProductModel> getProductById({required String productId});
}
