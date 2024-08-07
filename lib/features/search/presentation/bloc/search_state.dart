part of 'search_bloc.dart';

enum SearchStatus {
  initial,
  productsLoading,
  productsSuccess,
  productsFailure,
  brandsLoading,
  brandSuccess
}

@immutable
final class SearchState extends Equatable {
  final List<ProductEntity> products;
  final List<SelectableFacet> brands;
  final List<SelectableFacet> sizes;
  final List<SelectableFacet> colors;
  final int appliedFilterCount;
  final SearchStatus searchStatus;

  const SearchState(
      {this.products = const [],
      this.brands = const [],
      this.sizes = const [],
      this.colors = const [],
      this.appliedFilterCount = 0,
      this.searchStatus = SearchStatus.initial});

  @override
  List<Object?> get props =>
      [products, brands, sizes, colors, appliedFilterCount, searchStatus];

  SearchState copyWith(
      {List<ProductEntity>? products,
      List<SelectableFacet>? brands,
      List<SelectableFacet>? sizes,
      List<SelectableFacet>? colors,
      int? appliedFilterCount,
      SearchStatus? searchStatus}) {
    return SearchState(
        products: products ?? this.products,
        brands: brands ?? this.brands,
        sizes: sizes ?? this.sizes,
        colors: colors ?? this.colors,
        appliedFilterCount: appliedFilterCount ?? this.appliedFilterCount,
        searchStatus: searchStatus ?? this.searchStatus);
  }
}
