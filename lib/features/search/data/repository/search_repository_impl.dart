
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/product_entity.dart';
import 'package:urban_aura_flutter/features/search/data/datasource/search_data_source.dart';
import 'package:urban_aura_flutter/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource _searchDataSource;

  const SearchRepositoryImpl({required SearchDataSource searchDataSource})
      : _searchDataSource = searchDataSource;

  @override
  Stream<int> get appliedFilterCount => _searchDataSource.appliedFiltersCount;

  @override
  Stream<List<SelectableFacet>> get brandFacet => _searchDataSource.brandFacet;

  @override
  void clearFilters() {
    _searchDataSource.clearFilters();
  }

  @override
  Stream<List<SelectableFacet>> get colorFacet => _searchDataSource.colorFacet;

  @override
  Stream<List<ProductEntity>> get products => _searchDataSource.products;

  @override
  Stream<List<SelectableFacet>> get sizeFacet => _searchDataSource.sizeFacet;

  @override
  void toggleBrand({required String brand}) {
    _searchDataSource.toggleBrand(brand: brand);
  }

  @override
  void toggleColor({required String color}) {
    _searchDataSource.toggleColor(color: color);
  }

  @override
  void toggleSize({required String size}) {
    _searchDataSource.toggleSize(size: size);
  }

  @override
  void search({required String query}) {
    _searchDataSource.search(query : query);
  }
}
