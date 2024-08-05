import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/product_card.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/products/data/model/product_model.dart';
import 'package:urban_aura_flutter/features/products/domain/entity/product_entity.dart';

final class CustomSearchDelegate extends SearchDelegate {
  final HitsSearcher _productSearcher;
  final _filterState = FilterState();
  final CompositeDisposable _compositeDisposable = CompositeDisposable();
  late final FacetList _brandFacetList;
  late final FacetList _sizeFacetList;
  late final FacetList _colorFacetList;

  CustomSearchDelegate({required HitsSearcher hitSearcher})
      : _productSearcher = hitSearcher {
    _brandFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'brand');
    _sizeFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'size');
    _colorFacetList = _productSearcher.buildFacetList(
        filterState: _filterState, attribute: 'color');
    _productSearcher.connectFilterState(_filterState);

    _compositeDisposable
      ..add(_brandFacetList)
      ..add(_sizeFacetList)
      ..add(_colorFacetList)
      ..add(_filterState)
      ..add(_productSearcher);
  }

  Stream<List<ProductEntity>> get _searchProductPage =>
      _productSearcher.responses.map((response) =>
          response.hits.map(ProductModel.fromAlgoliaResponse).toList());

  Stream<int> get appliedFiltersCount =>
      _filterState.filters.map((event) => event.getFilters().length);

  Stream<List<SelectableFacet>> get brandFacets => _brandFacetList.facets;

  Stream<List<SelectableFacet>> get colorFacets => _colorFacetList.facets;

  Stream<List<SelectableFacet>> get sizeFacets => _sizeFacetList.facets;

  void toggleBrand(String brand) {
    _brandFacetList.toggle(brand);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  void toggleColor(String color) {
    _colorFacetList.toggle(color);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  void toggleSize(String color) {
    _sizeFacetList.toggle(color);
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }

  void clearFilters() {
    _filterState.clear();
    _productSearcher.applyState((state) => state.copyWith(page: 0));
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = '';
          _productSearcher.dispose();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    _productSearcher.query(query);

    return StreamBuilder(
      stream: _searchProductPage,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Icon(Icons.error);
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              strokeCap: StrokeCap.round,
              color: AppPalette.primaryColor,
            ),
          );
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }
        return GridView.builder(
          itemCount: snapshot.data?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.5),
          itemBuilder: (context, index) {
            final product = snapshot.data?[index];
            return GestureDetector(
              onTap: () => context.push(
                '/products/${product.name}',
                extra: product,
              ),
              child: ProductCard(
                product: product!,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: _searchProductPage,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Icon(Icons.error);
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              strokeCap: StrokeCap.round,
              color: AppPalette.primaryColor,
            ),
          );
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }
        return GridView.builder(
          itemCount: snapshot.data?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.5),
          itemBuilder: (context, index) {
            final product = snapshot.data?[index];
            return GestureDetector(
              onTap: () => context.push(
                '/products/${product.name}',
                extra: product,
              ),
              child: ProductCard(
                product: product!,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _compositeDisposable.dispose();
  }
}
