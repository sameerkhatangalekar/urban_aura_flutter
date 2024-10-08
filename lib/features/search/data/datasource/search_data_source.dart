import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/core/common/data/models/product_model.dart';

abstract interface class SearchDataSource {
  Stream<List<ProductModel>> get products;

  Stream<int> get appliedFiltersCount;

  Stream<List<SelectableFacet>> get brandFacet;

  Stream<List<SelectableFacet>> get colorFacet;

  Stream<List<SelectableFacet>> get sizeFacet;

  void toggleBrand({required String brand});

  void toggleColor({required String color});

  void toggleSize({required String size});

  void search({required String query});

  void clearFilters();
}
