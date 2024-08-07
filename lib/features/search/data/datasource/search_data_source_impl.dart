import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:urban_aura_flutter/core/common/data/models/product_model.dart';

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
        filterState: _filterState, attribute: 'sizes');
    _colorFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'colors');
    _productSearcher.connectFilterState(_filterState);
  }

  @override
  Stream<int> get appliedFiltersCount =>
      _filterState.filters.map((event) => event.getFilters().length);

  @override
  Stream<List<SelectableFacet>> get brandFacet => _brandFacetList.facets;

  @override
  Stream<List<SelectableFacet>> get colorFacet => _colorFacetList.facets;

  @override
  Stream<List<SelectableFacet>> get sizeFacet => _sizeFacetList.facets;

  @override
  void clearFilters() {
    _filterState.clear();
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  @override
  void toggleBrand({required String brand}) {
    _brandFacetList.toggle(brand);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  @override
  void toggleColor({required String color}) {
    _colorFacetList.toggle(color);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  @override
  void toggleSize({required String size}) {
    _sizeFacetList.toggle(size);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  @override
  Stream<List<ProductModel>> get products =>
      _productSearcher.responses.map((response) =>
          response.hits.map(ProductModel.fromAlgoliaResponse).toList());

  @override
  void search({required String query}) {
    _productSearcher.query(query);
  }
}
