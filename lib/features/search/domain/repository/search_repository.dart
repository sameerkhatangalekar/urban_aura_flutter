import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';

abstract interface class SearchRepository {
  Stream<List<ProductEntity>> get products;

  Stream<int> get appliedFilterCount;

  Stream<List<SelectableFacet>> get brandFacet;

  Stream<List<SelectableFacet>> get colorFacet;

  Stream<List<SelectableFacet>> get sizeFacet;

  void toggleBrand({required String brand});

  void toggleColor({required String color});

  void toggleSize({required String size});

  void search({required String query});

  void clearFilters();
}
