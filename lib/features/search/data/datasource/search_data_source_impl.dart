import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/features/products/data/model/product_model.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

import 'search_data_source.dart';

class SearchDataSourceImpl implements SearchDataSource {
  final HitsSearcher _productSearcher;
  final FilterState _filterState;
  late final FacetList _brandFacetList;
  late final FacetList _sizeFacetList;
  late final FacetList _colorFacetList;

  SearchDataSourceImpl(
      {required HitsSearcher productSearcher, required FilterState filterState})
      : _productSearcher = productSearcher,
        _filterState = filterState {
    _brandFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'brand');
    _sizeFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'size');
    _colorFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'color');
    _productSearcher.connectFilterState(_filterState);
  }

  @override
  Stream<int> get appliedFiltersCount =>
      _filterState.filters.map((event) => event.getFilters().length);

  @override
  Stream<List<SelectableFacet>> get brandFacet => _brandFacetList.facets;

  @override
  Stream<List<SelectableFacet>> get colorFacet => _brandFacetList.facets;

  @override

  Stream<List<ProductEntity>> get products =>
      _productSearcher.responses.map((response) =>
          response.hits.map(ProductModel.fromAlgoliaResponse).toList());

  @override
  // TODO: implement sizeFacet
  Stream<List<SelectableFacet>> get sizeFacet => throw UnimplementedError();

  @override
  void clearFilters() {
    _filterState.clear();
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  @override
  void toggleBrand({required String brand}) {
    // TODO: implement toggleBrand
  }

  @override
  void toggleColor({required String color}) {
    // TODO: implement toggleColor
  }

  @override
  void toggleSize({required String size}) {
    // TODO: implement toggleSize
  }
}
