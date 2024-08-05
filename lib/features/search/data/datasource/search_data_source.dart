import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

abstract interface class SearchDataSource {
  Stream<List<ProductEntity>> get products;

  Stream<int> get appliedFiltersCount;

  Stream<List<SelectableFacet>> get brandFacet;

  Stream<List<SelectableFacet>> get colorFacet;

  Stream<List<SelectableFacet>> get sizeFacet;

  void toggleBrand({required String brand});

  void toggleColor({required String color});

  void toggleSize({required String size});

  void clearFilters();
}
